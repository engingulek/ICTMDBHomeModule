//
//  ICTMDBHomeModuleTests.swift
//  ICTMDBHomeModuleTests
//
//  Created by Engin Gülek on 12.11.2025.
//

import Testing
import GenericCollectionViewKit
import ICTMDBViewKit
@testable import ICTMDBHomeModule

struct ICTMDBHomeModuleTests {
    
    private var view: MockHomeViewController!
    private var interactor: MockHomeInteractor!
    private var presenter: HomePresenter!
    private var router: MockHomeRouter!
    
    init() {
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(
            view: view,
            interactor: interactor,
            router: router
        )
        interactor.presenter = presenter
    }

    @Test("Set background color on view load")
    func testBackgroundColor() async throws {
        #expect(view.invokedSetBackColorAble == false)
        #expect(view.invokedSetBackColorAbleCount == 0)
        #expect(view.invokedSetBackColorAbleData == [])
        
        presenter.viewDidLoad()
        
        #expect(view.invokedSetBackColorAble == true)
        #expect(view.invokedSetBackColorAbleCount == 1)
        #expect(view.invokedSetBackColorAbleData == ["backColor"])
    }
    
    @Test("Check number of sections")
    func testNumberOfSections() {
        presenter.viewDidLoad()
        
        let sectionCount = presenter.numberOfSections()
        
        #expect(sectionCount == 2)
    }
    
    @Test("Popular section layout")
    func testPopularLayout() {
        presenter.viewDidLoad()
        
        let layout = presenter.layout(for: 0)
        let expected = LayoutSourceTeamplate.horizontalSingleRow.template
        
        // #expect(layout == expected)
    }
    
    @Test("Airing today section layout")
    func testAiringTodayLayout() {
        presenter.viewDidLoad()
        
        let layout = presenter.layout(for: 1)
        let expected = LayoutSourceTeamplate.verticalTwoPerRow.template
        
        // #expect(layout == expected)
    }
    
    @Test("Check section type")
    func testSectionType() {
        presenter.viewDidLoad()
        
        let popularSection = presenter.sectionType(at: 0)
        #expect(popularSection == .popular)
        
        let airingSection = presenter.sectionType(at: 1)
        #expect(airingSection == .airingToday)
    }
    
    @Test("Title configuration for popular section")
    func testTitleForPopularSection() async throws {
        presenter.viewDidLoad()
        
        let item = presenter.titleForSection(at: 0)
        
        #expect(item.title == LocalizableUI.popular.localized)
        #expect(item.sizeType == .large)
        #expect(item.buttonType?.contains { if case .allList = $0 { return true } else { return false } } == true)
    }
    
    @Test("Title configuration for airing today section")
    func testTitleForAiringTodaySection() async throws {
        presenter.viewDidLoad()
        
        let item = presenter.titleForSection(at: 1)
        
        #expect(item.title == LocalizableUI.airingToday.localized)
        #expect(item.sizeType == .small)
        #expect(item.buttonType?.contains { if case .allList = $0 { return true } else { return false } } == true)
    }
    
    
    @Test("Handle tapping title button in popular section")
    func testOnTappedTitleButtonForPopular() async throws {
        presenter.viewDidLoad()
        #expect(router.invokedPopular == false)
        
        presenter.onTappedTitleButton(buttonType: .allList, section: 0)
        
        #expect(router.invokedPopular == true)
    }
    
    @Test("Handle tapping title button in airing today section")
    func testOnTappedTitleButtonForAiring() async throws {
        presenter.viewDidLoad()
        #expect(router.invokedAiring == false)
        
        presenter.onTappedTitleButton(buttonType: .allList, section: 1)
        
        #expect(router.invokedAiring == true)
    }
    
    @Test("Reload collection view on view load")
    func testReloadCollectionView() async throws {
        #expect(view.invokedRelaodCollectionView == false)
        #expect(view.invokedRelaodCollectionViewCount == 0)
        
        presenter.viewDidLoad()
        
        #expect(view.invokedRelaodCollectionView == true)
        #expect(view.invokedRelaodCollectionViewCount == 2)
    }
    
    @Test("Start loading animation on view load")
    func testStartLoadingAnimation() async throws {
        #expect(view.invokedStartLoading == false)
        #expect(view.invokedStartLoadingCount == 0)
        
        presenter.viewDidLoad()
        
        #expect(view.invokedStartLoading == true)
        #expect(view.invokedStartLoadingCount == 2)
    }
    
    @Test("Stop loading animation on view load")
    func testStopLoadingAnimation() async throws {
        #expect(view.invokedFinishLoading == false)
        #expect(view.invokedFinishLoadingCount == 0)
        
        presenter.viewDidLoad()
        
        #expect(view.invokedFinishLoading == true)
        #expect(view.invokedFinishLoadingCount == 2)
    }
    
    @Test("Display error message when interactor fails")
    func testErrorHandling() async throws {
        #expect(view.invokedSendError == false)
        #expect(view.invokedSendErrorCount == 0)
        
        interactor.loadError = true
        presenter.viewDidLoad()
        
        #expect(view.invokedSendError == true)
        #expect(view.invokedSendErrorCount == 2)
        #expect(view.invokedSendErrorData.map(\.isHidden) == [true, true])
        #expect(view.invokedSendErrorData.map(\.message) == [
            LocalizableUI.somethingWentWrong.localized,
            LocalizableUI.somethingWentWrong.localized
        ])
    }
}

