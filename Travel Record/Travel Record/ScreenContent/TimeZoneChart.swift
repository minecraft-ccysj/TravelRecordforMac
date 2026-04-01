//
//  FlightTimeZone.swift
//  Travel Record
//
//  Created by Christophe Lee on 1/22/26.
//

import Foundation

struct TimeZoneChart{
    //机场ITAT -> 时区
    static let zoneChart: [String: String] = [
        // ================= China =================
        "PEK": "Asia/Shanghai",
        "PKX": "Asia/Shanghai",
        "PVG": "Asia/Shanghai",
        "SHA": "Asia/Shanghai",
        "CAN": "Asia/Shanghai",
        "SZX": "Asia/Shanghai",
        "CTU": "Asia/Shanghai",
        "CKG": "Asia/Shanghai",
        "XIY": "Asia/Shanghai",
        "HGH": "Asia/Shanghai",
        "WUH": "Asia/Shanghai",
        "NKG": "Asia/Shanghai",
        "XMN": "Asia/Shanghai",
        "FOC": "Asia/Shanghai",
        "KMG": "Asia/Shanghai",
        "TAO": "Asia/Shanghai",
        "DLC": "Asia/Shanghai",
        "TSN": "Asia/Shanghai",

        // ================= Taiwan =================
        "TPE": "Asia/Taipei",
        "TSA": "Asia/Taipei",
        "KHH": "Asia/Taipei",

        // ================= Hong Kong / Macau =================
        "HKG": "Asia/Hong_Kong",
        "MFM": "Asia/Macau",

        // ================= Japan =================
        "NRT": "Asia/Tokyo",
        "HND": "Asia/Tokyo",
        "KIX": "Asia/Tokyo",
        "ITM": "Asia/Tokyo",
        "NGO": "Asia/Tokyo",
        "FUK": "Asia/Tokyo",
        "CTS": "Asia/Tokyo",
        "OKA": "Asia/Tokyo",

        // ================= South Korea =================
        "ICN": "Asia/Seoul",
        "GMP": "Asia/Seoul",
        "PUS": "Asia/Seoul",

        // ================= Southeast Asia =================
        "SIN": "Asia/Singapore",
        "BKK": "Asia/Bangkok",
        "DMK": "Asia/Bangkok",
        "KUL": "Asia/Kuala_Lumpur",
        "CGK": "Asia/Jakarta",
        "DPS": "Asia/Makassar",
        "MNL": "Asia/Manila",
        "SGN": "Asia/Ho_Chi_Minh",
        "HAN": "Asia/Ho_Chi_Minh",

        // ================= Middle East =================
        "DXB": "Asia/Dubai",
        "DWC": "Asia/Dubai",
        "AUH": "Asia/Dubai",
        "DOH": "Asia/Qatar",
        "RUH": "Asia/Riyadh",
        "JED": "Asia/Riyadh",
        "TLV": "Asia/Jerusalem",

        // ================= USA (West) =================
        "LAX": "America/Los_Angeles",
        "SAN": "America/Los_Angeles",
        "SFO": "America/Los_Angeles",
        "SEA": "America/Los_Angeles",
        "SJC": "America/Los_Angeles",
        "OAK": "America/Los_Angeles",
        "LAS": "America/Los_Angeles",
        "PDX": "America/Los_Angeles",

        // ================= USA (Mountain) =================
        "DEN": "America/Denver",
        "PHX": "America/Phoenix",
        "SLC": "America/Denver",

        // ================= USA (Central) =================
        "ORD": "America/Chicago",
        "DFW": "America/Chicago",
        "IAH": "America/Chicago",
        "DAL": "America/Chicago",
        "MSP": "America/Chicago",

        // ================= USA (East) =================
        "JFK": "America/New_York",
        "EWR": "America/New_York",
        "LGA": "America/New_York",
        "BOS": "America/New_York",
        "ATL": "America/New_York",
        "MIA": "America/New_York",
        "IAD": "America/New_York",
        "DCA": "America/New_York",

        // ================= Canada =================
        "YYZ": "America/Toronto",
        "YUL": "America/Toronto",
        "YVR": "America/Vancouver",
        "YYC": "America/Edmonton",

        // ================= Europe =================
        "LHR": "Europe/London",
        "LGW": "Europe/London",
        "CDG": "Europe/Paris",
        "ORY": "Europe/Paris",
        "FRA": "Europe/Berlin",
        "MUC": "Europe/Berlin",
        "AMS": "Europe/Amsterdam",
        "MAD": "Europe/Madrid",
        "BCN": "Europe/Madrid",
        "FCO": "Europe/Rome",
        "MXP": "Europe/Rome",
        "ZRH": "Europe/Zurich",
        "VIE": "Europe/Vienna",
        "IST": "Europe/Istanbul",

        // ================= Australia / NZ =================
        "SYD": "Australia/Sydney",
        "MEL": "Australia/Melbourne",
        "BNE": "Australia/Brisbane",
        "PER": "Australia/Perth",
        "AKL": "Pacific/Auckland",
        "CHC": "Pacific/Auckland"
    ]
    
    static func timeZoneID(for airportCode: String) -> String {
            let code = airportCode.uppercased()
            return zoneChart[code] ?? TimeZone.current.identifier
        }
}
