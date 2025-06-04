# TMDB Movie Info Application
## Quick Setup
1. Create a new XCode project named "MovieInfo".
2. To quickly run this application, run `git clone https://github.com/rishabhg19/MovieInfo.git`. Then copy the cloned repository directory `MovieInfo` into the directory auto-generated when you created the project (this will also be named `MovieInfo`). The directory structure should look something like below.
 ```
MovieInfo/
└── MovieInfo.xcodeproj
└── MovieInfoTests
└── MovieInfoUITests
└── MovieInfo/
    ├── Utils/
    │   ├── TMDBAPICaller.swift
    │   └── CacheManager.swift
    ├── Views/
    │   ├── FavoritesView.swift
    │   ├── MovieDetailsView.swift
    │   └── TrendingView.swift
    ├── DataModels/
    │   ├── Movie.swift
    │   └── MovieDetailModel.swift
    ├── AppRoot.swift
    ├── Info.plist
    ├── Assets.xcassets/
    └── MovieInfoApp.swift

```
3. Set up an API Key and get a read access token for TMDB by following the instructions [here](https://developer.themoviedb.org/docs/getting-started).
4. Open `TMDBAPICaller.swift` and replace the value on line 12 with your read access token. It will look something like below. IMPORTANT - DO NOT upload your read access token or API key publicly. Use Secrets.xcconfig with Info.plist to secure your API credentials.
<img width="847" alt="Screenshot 2025-06-04 at 6 12 03 PM" src="https://github.com/user-attachments/assets/f60f1c0f-212d-4f27-b221-ce8d9b659c7e" />

5. Build and run the project.
   
![Simulator Screenshot - iPhone 16 Pro - 2025-06-04 at 17 39 34](https://github.com/user-attachments/assets/fa8e6826-8687-4f6f-a337-77aca3b42bb9)


## Credits
[https://medium.com/@jpmtech/make-and-parse-an-api-call-using-swiftui-32f970e2b067]
[https://www.youtube.com/watch?v=77ztC8Z-KuQ]
[https://www.youtube.com/watch?v=U5GBl7olOA0]
