import Foundation

struct NetworkService {
    static func request(for configuration: AppConfiguration) {
        let url: URL

        switch configuration {
        case .people(let u), .starship(let u), .planet(let u):
            url = u
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                // -1009 (NSURLErrorNotConnectedToInternet)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("✅ Status Code: \(httpResponse.statusCode)")
                print("✅ Headers: \(httpResponse.allHeaderFields)")
            }

            if let data = data, let string = String(data: data, encoding: .utf8) {
                print("📦 Data as string:\n\(string)")
            }
        }

        task.resume()
    }
}
