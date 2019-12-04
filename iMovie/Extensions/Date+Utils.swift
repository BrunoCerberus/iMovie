//
//  Date+Utils.swift
//  iMovie
//
//  Created by bruno on 04/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

extension Date {
    enum FormatStyle: String {
        case longDateTime = "dd/MM/yyyy 'às' HH:mm"
        case longDateTimeDetailed = "dd/MM/yyyy 'às' HH:mm:SS"
        case shortDate = "dd/MM/yyyy"
        case reversedStashedDate = "yyyy-MM-dd"
        case longDateTimeGMT = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case longDateTimeGMTLoan = "yyyy-MM-dd'T'HH:mm:ss.sss'Z'"
        case longDateTimeGMTQuickSale = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        case longDateTimeGMTRewards = "yyyy-MM-dd'T'HH:mm:ss"
        case longDateTimeGMTServices = "yyyy-MM-dd HH:mm:ss.SSS"
        case fullDateWithTimeZone = "yyyy-MM-dd'T'HH:mm:ssZ"
        case shortDayMonthDate = "dd MMM"
        case dayMonthDate = "dd/MM"
        case longDateTimeDetailGMT = "yyyy-MM-dd HH:mm:SS"
        case monthYear = "MM/yy"
        case timeDate = "HH:mm"
        case longDateTimeBRT = "dd/MM/yyyy HH:mm:ss"
        case longDateDetail = "dd 'de' MMMM 'de' yyyy"
        case middleDateHour = "yyMMddHHmm"
        case yearDate = "yyyy"
        case shortMonthName = "MMM"
        case monthAndYearName = "MMMM yyyy"
        case month = "MMMM"
        case longDateTimeGMTPaymentLink = "yyyy-MM-dd'T'23:59:59ZZZZZ"
    }
    
    func toString(with format: FormatStyle) -> String {
        return toString(withFormat: format.rawValue)
    }

    func toString(withFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        dateFormatter.locale = Locale.init(identifier: "pt_BR")
        return dateFormatter.string(from: self)
    }
    
    func isDateOver(_ years: Int) -> Bool {
        let ageComponents = Calendar.current.dateComponents([.year], from: self, to: Date())
        guard let age = ageComponents.year else {
            return false
        }
        return age >= years
    }
}

extension TimeInterval {
    func toString() -> String {
        return String(self)
    }
}

extension Date {
    func isGreaterThanDate(dateToCompare: Date) -> Bool {
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending {
            return true
        }
        return false
    }
}
