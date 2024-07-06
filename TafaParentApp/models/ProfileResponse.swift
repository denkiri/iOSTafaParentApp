struct ProfileResponse: Codable {
    let details: UserDetails
}

struct UserDetails: Codable {
    let id: String
    let username: String
    let password_changed: Bool // Note the underscore in property name to match JSON
    let date_created: String // You might want to convert this to Date type using a custom DateFormatter if needed
    let profile: ProfileDetails
    let global_configs: GlobalConfigs // Note the underscore in property name to match JSON
}

struct ProfileDetails: Codable {
    let DT_RowId: String
    let DT_RowAttr: RowAttr
    let id: String
    let username: String
    let name: String
    let students: [Student]
    let students_count: Int
    let status: String
    let date_created: String
}

struct RowAttr: Codable {
    let pk: String
}

struct Student: Codable {
    let DT_RowId: String // Note the property name matching JSON
    let DT_RowAttr: RowAttr
    let id: String
    let username: String
    let name: String
    let contact_count: Int // Note the underscore in property name to match JSON
    let school: String
    let status: String
    let date_created: String // You might want to convert this to Date type using a custom DateFormatter if needed
    let token: Double? // Optional because it can be null/nil in JSON
    let token_rate_per_min: Double
    let student_activation: String
}

struct GlobalConfigs: Codable {
    let minimum_student_token: Double // Note the underscore in property name to match JSON
    let minimum_device_minutes: Double // Note the underscore in property name to match JSON
    let minimum_device_tokens: Double // Note the underscore in property name to match JSON
}

