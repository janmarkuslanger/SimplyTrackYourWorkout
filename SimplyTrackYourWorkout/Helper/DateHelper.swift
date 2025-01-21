class DateHelper {
    static let shared = DateHelper()

    private let formatter: DateFormatter

    private init() {
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Format für das Datum
    }

    func string(from date: Date) -> String {
        return formatter.string(from: date)
    }

    func date(from string: String) -> Date? {
        return formatter.date(from: string)
    }
}
