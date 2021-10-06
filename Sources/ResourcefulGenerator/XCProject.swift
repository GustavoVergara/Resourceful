import Foundation
import XcodeEdit

struct BuildConfiguration {
    let name: String
}

struct XCProject {
    static let supportedExtensions: Set<String> = ["xcodeproj"]
    
    private let projectFile: XCProjectFile
    
    let developmentLanguage: String
    
    init(url: URL) throws {
        if Self.supportedExtensions.contains(url.pathExtension) == false {
            throw URLError(.unknown)
        }
//        try Xcodeproj.throwIfUnsupportedExtension(url.pathExtension)
        let projectFile: XCProjectFile
        
        // Parse project file
        do {
            do {
                projectFile = try XCProjectFile(xcodeprojURL: url)
            }
            catch let error as ProjectFileError {
//                warn(error.localizedDescription)
                
                projectFile = try XCProjectFile(xcodeprojURL: url, ignoreReferenceErrors: true)
            }
        }
        catch {
            throw URLError(.unknown)
//            throw ResourceParsingError.parsingFailed("Project file at '\(url)' could not be parsed, is this a valid Xcode project file ending in *.xcodeproj?\n\(error.localizedDescription)")
        }
        
        self.projectFile = projectFile
        self.developmentLanguage = projectFile.project.developmentRegion
    }
    
    private func findTarget(name: String) throws -> PBXTarget {
        // Look for target in project file
        let allTargets = projectFile.project.targets.compactMap { $0.value }
        guard let target = allTargets.filter({ $0.name == name }).first else {
            throw URLError(.unknown)
//            let availableTargets = allTargets.compactMap { $0.name }.joined(separator: ", ")
//            throw ResourceParsingError.parsingFailed("Target '\(name)' not found in project file, available targets are: \(availableTargets)")
        }
        
        return target
    }
    
    func resourceURLs(forTarget targetName: String, sourceURLs: SourceFolderURLs) throws -> [URL] {
        let target = try findTarget(name: targetName)
        
        let resourcesFileRefs = target.buildPhases
            .compactMap { $0.value as? PBXResourcesBuildPhase }
            .flatMap { $0.files }
            .compactMap { $0.value?.fileRef }
        
        let fileRefPaths = resourcesFileRefs
            .compactMap { $0.value as? PBXFileReference }
            .compactMap { $0.fullPath }
        
        let variantGroupPaths = resourcesFileRefs
            .compactMap { $0.value as? PBXVariantGroup }
            .flatMap { $0.fileRefs }
            .compactMap { $0.value?.fullPath }
        
        return (fileRefPaths + variantGroupPaths).map { $0.url(with: sourceURLs.urlForSourceTreeFolder(_:)) }
    }
    
//    func buildConfigurations(forTarget targetName: String) throws -> [BuildConfiguration] {
//        let target = try findTarget(name: targetName)
//
//        guard let buildConfigurationList = target.buildConfigurationList.value else { return [] }
//
//        let buildConfigurations = buildConfigurationList.buildConfigurations
//            .compactMap { $0.value }
//            .compactMap { configuration -> BuildConfiguration? in
//                return BuildConfiguration(name: configuration.name)
//            }
//
//        return buildConfigurations
//    }
}

struct SourceFolderURLs {
    let buildProductsDirURL: URL
    let developerDirURL: URL
    let sourceRootURL: URL
    let sdkRootURL: URL
    let platformURL: URL
}

private extension SourceFolderURLs {
    func urlForSourceTreeFolder(_ sourceTreeFolder: SourceTreeFolder) -> URL {
        switch sourceTreeFolder {
        case .buildProductsDir:
            return buildProductsDirURL
        case .developerDir:
            return developerDirURL
        case .sdkRoot:
            return sdkRootURL
        case .sourceRoot:
            return sourceRootURL
        case .platformDir:
            return platformURL
        }
    }
}
