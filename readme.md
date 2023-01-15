
# BeautyPhora
built with UIKit, in a clean architecture using the MVVM design pattern and repository pattern. The app communicates with the APIto fetch data, store them in cache using `DAOLayer` and has unit & integration tests for the network layer / Data / ViewModels.

## Features
- Asynchronous fetch from server
- Caching system using `CoreData`
- Reactive programming using `RxSwift`
- Compositionnal Layout CollectionView

## Clean Architecture
Built using the MVVM design pattern, which helps to separate the UI code from the business logic. 
The repository pattern is used to abstract the data access layer aka RemoteRepository / LocalRepository.

## Tests
Unit tests have been written for the network layer to ensure reliable communication with the backend server.
Integration Tests using custom mocks to test repositories and View models.
These tests can be run by navigating to the Tests folder in Xcode and running the BeautyPhoraTests target.

## Requirements
iOS 15.0+ | Because of one line --> `.formatted(.currency(code: "EUR"))` | tx Apple
Xcode 13+

## Overview
- MVVM, Repository Design Pattern access RemoteRepository / LocalRepository
- Dependency Injection for easier testing and respect of rule #5 _Dependency inversion principle_ (Aka SOLID principles)
- Network layer and Local Data built in Test Driven Dev | All the network and API fetch are built using Testing.
- Uses RxSwift Event/Notification Based for data delivery.
- Uses Mocks and Stubs for Unit testing
- Uses Reactive programming with RxSwift / UIKit

## Depencencies

pod `RxSwift`

## Installation
`Clone` the main repository, `pod install`, build and run


## Screenshots

Dark - Light Support


[![Light2](/screenshot/screenshot2.png)]
[![Light3](/screenshot/screenshot3.png)]
[![Light4](/screenshot/screenshot1.png)]

[![Tests](/screenshot/screenshot1-test.png)]
