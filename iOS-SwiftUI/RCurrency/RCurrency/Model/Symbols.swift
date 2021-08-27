//
//  Symbols.swift
//  Symbols
//
//  Created by Andrew Morgan on 27/08/2021.
//

import Foundation


class Symbols {
    var motd = Motd()
    var success = false
    var symbols = Dictionary<String, String>()
}

extension Symbols {
    static var data = Symbols()
    
    static func loadData() {
        data.symbols["AED"] = "United Arab Emirates Dirham"
        data.symbols["AFN"] = "Afghan Afghani"
        data.symbols["ALL"] = "Albanian Lek"
        data.symbols["AMD"] = "Armenian Dram"
        data.symbols["ANG"] = "Netherlands Antillean Guilder"
        data.symbols["AOA"] = "Angolan Kwanza"
        data.symbols["ARS"] = "Argentine Peso"
        data.symbols["AUD"] = "Australian Dollar"
        data.symbols["AWG"] = "Aruban Florin"
        data.symbols["AZN"] = "Azerbaijani Manat"
        data.symbols["BAM"] = "Bosnia-Herzegovina Convertible Mark"
        data.symbols["BBD"] = "Barbadian Dollar"
        data.symbols["BDT"] = "Bangladeshi Taka"
        data.symbols["BGN"] = "Bulgarian Lev"
        data.symbols["BHD"] = "Bahraini Dinar"
        data.symbols["BIF"] = "Burundian Franc"
        data.symbols["BMD"] = "Bermudan Dollar"
        data.symbols["BND"] = "Brunei Dollar"
        data.symbols["BOB"] = "Bolivian Boliviano"
        data.symbols["BRL"] = "Brazilian Real"
        data.symbols["BSD"] = "Bahamian Dollar"
        data.symbols["BTC"] = "Bitcoin"
        data.symbols["BTN"] = "Bhutanese Ngultrum"
        data.symbols["BWP"] = "Botswanan Pula"
        data.symbols["BYN"] = "Belarusian Ruble"
        data.symbols["BZD"] = "Belize Dollar"
        data.symbols["CAD"] = "Canadian Dollar"
        data.symbols["CDF"] = "Congolese Franc"
        data.symbols["CHF"] = "Swiss Franc"
        data.symbols["CLP"] = "Chilean Peso"
        data.symbols["CNY"] = "Chinese Yuan"
        data.symbols["COP"] = "Colombian Peso"
        data.symbols["CRC"] = "Costa Rican Colón"
        data.symbols["CUP"] = "Cuban Peso"
        data.symbols["CVE"] = "Cape Verdean Escudo"
        data.symbols["CZK"] = "Czech Republic Koruna"
        data.symbols["DJF"] = "Djiboutian Franc"
        data.symbols["DKK"] = "Danish Krone"
        data.symbols["DOP"] = "Dominican Peso"
        data.symbols["DZD"] = "Algerian Dinar"
        data.symbols["EGP"] = "Egyptian Pound"
        data.symbols["ERN"] = "Eritrean Nakfa"
        data.symbols["ETB"] = "Ethiopian Birr"
        data.symbols["EUR"] = "Euro"
        data.symbols["FJD"] = "Fijian Dollar"
        data.symbols["FKP"] = "Falkland Islands Pound"
        data.symbols["GBP"] = "British Pound Sterling"
        data.symbols["GEL"] = "Georgian Lari"
        data.symbols["GHS"] = "Ghanaian Cedi"
        data.symbols["GIP"] = "Gibraltar Pound"
        data.symbols["GMD"] = "Gambian Dalasi"
        data.symbols["GNF"] = "Guinean Franc"
        data.symbols["GTQ"] = "Guatemalan Quetzal"
        data.symbols["GYD"] = "Guyanaese Dollar"
        data.symbols["HKD"] = "Hong Kong Dollar"
        data.symbols["HNL"] = "Honduran Lempira"
        data.symbols["HRK"] = "Croatian Kuna"
        data.symbols["HTG"] = "Haitian Gourde"
        data.symbols["HUF"] = "Hungarian Forint"
        data.symbols["IDR"] = "Indonesian Rupiah"
        data.symbols["ILS"] = "Israeli New Sheqel"
        data.symbols["INR"] = "Indian Rupee"
        data.symbols["IQD"] = "Iraqi Dinar"
        data.symbols["IRR"] = "Iranian Rial"
        data.symbols["ISK"] = "Icelandic Króna"
        data.symbols["JMD"] = "Jamaican Dollar"
        data.symbols["JOD"] = "Jordanian Dinar"
        data.symbols["JPY"] = "Japanese Yen"
        data.symbols["KES"] = "Kenyan Shilling"
        data.symbols["KGS"] = "Kyrgystani Som"
        data.symbols["KHR"] = "Cambodian Riel"
        data.symbols["KMF"] = "Comorian Franc"
        data.symbols["KPW"] = "North Korean Won"
        data.symbols["KRW"] = "South Korean Won"
        data.symbols["KWD"] = "Kuwaiti Dinar"
        data.symbols["KYD"] = "Cayman Islands Dollar"
        data.symbols["KZT"] = "Kazakhstani Tenge"
        data.symbols["LAK"] = "Laotian Kip"
        data.symbols["LBP"] = "Lebanese Pound"
        data.symbols["LKR"] = "Sri Lankan Rupee"
        data.symbols["LRD"] = "Liberian Dollar"
        data.symbols["LYD"] = "Libyan Dinar"
        data.symbols["MAD"] = "Moroccan Dirham"
        data.symbols["MDL"] = "Moldovan Leu"
        data.symbols["MGA"] = "Malagasy Ariary"
        data.symbols["MKD"] = "Macedonian Denar"
        data.symbols["MMK"] = "Myanma Kyat"
        data.symbols["MNT"] = "Mongolian Tugrik"
        data.symbols["MOP"] = "Macanese Pataca"
        data.symbols["MRO"] = "Mauritanian Ouguiya (pre-2018)"
        data.symbols["MUR"] = "Mauritian Rupee"
        data.symbols["MVR"] = "Maldivian Rufiyaa"
        data.symbols["MWK"] = "Malawian Kwacha"
        data.symbols["MXN"] = "Mexican Peso"
        data.symbols["MYR"] = "Malaysian Ringgit"
        data.symbols["MZN"] = "Mozambican Metical"
        data.symbols["NAD"] = "Namibian Dollar"
        data.symbols["NGN"] = "Nigerian Naira"
        data.symbols["NIO"] = "Nicaraguan Córdoba"
        data.symbols["NOK"] = "Norwegian Krone"
        data.symbols["NPR"] = "Nepalese Rupee"
        data.symbols["NZD"] = "New Zealand Dollar"
        data.symbols["OMR"] = "Omani Rial"
        data.symbols["PEN"] = "Peruvian Nuevo Sol"
        data.symbols["PGK"] = "Papua New Guinean Kina"
        data.symbols["PHP"] = "Philippine Peso"
        data.symbols["PKR"] = "Pakistani Rupee"
        data.symbols["PLN"] = "Polish Zloty"
        data.symbols["PYG"] = "Paraguayan Guarani"
        data.symbols["QAR"] = "Qatari Rial"
        data.symbols["RON"] = "Romanian Leu"
        data.symbols["RSD"] = "Serbian Dinar"
        data.symbols["RUB"] = "Russian Ruble"
        data.symbols["RWF"] = "Rwandan Franc"
        data.symbols["SAR"] = "Saudi Riyal"
        data.symbols["SBD"] = "Solomon Islands Dollar"
        data.symbols["SCR"] = "Seychellois Rupee"
        data.symbols["SEK"] = "Swedish Krona"
        data.symbols["SGD"] = "Singapore Dollar"
        data.symbols["SHP"] = "Saint Helena Pound"
        data.symbols["SLL"] = "Sierra Leonean Leone"
        data.symbols["SOS"] = "Somali Shilling"
        data.symbols["SRD"] = "Surinamese Dollar"
        data.symbols["STD"] = "São Tomé and Príncipe Dobra (pre-2018)"
        data.symbols["SVC"] = "Salvadoran Colón"
        data.symbols["SYP"] = "Syrian Pound"
        data.symbols["SZL"] = "Swazi Lilangeni"
        data.symbols["THB"] = "Thai Baht"
        data.symbols["TJS"] = "Tajikistani Somoni"
        data.symbols["TND"] = "Tunisian Dinar"
        data.symbols["TOP"] = "Tongan Pa'anga"
        data.symbols["TRY"] = "Turkish Lira"
        data.symbols["TTD"] = "Trinidad and Tobago Dollar"
        data.symbols["TWD"] = "New Taiwan Dollar"
        data.symbols["TZS"] = "Tanzanian Shilling"
        data.symbols["UAH"] = "Ukrainian Hryvnia"
        data.symbols["UGX"] = "Ugandan Shilling"
        data.symbols["USD"] = "United States Dollar"
        data.symbols["UYU"] = "Uruguayan Peso"
        data.symbols["UZS"] = "Uzbekistan Som"
        data.symbols["VEF"] = "Venezuelan Bolívar Fuerte (Old)"
        data.symbols["VND"] = "Vietnamese Dong"
        data.symbols["VUV"] = "Vanuatu Vatu"
        data.symbols["WST"] = "Samoan Tala"
        data.symbols["XAF"] = "CFA Franc BEAC"
        data.symbols["XCD"] = "East Caribbean Dollar"
        data.symbols["XOF"] = "CFA Franc BCEAO"
        data.symbols["XPF"] = "CFP Franc"
        data.symbols["YER"] = "Yemeni Rial"
        data.symbols["ZAR"] = "South African Rand"
        data.symbols["ZMW"] = "Zambian Kwacha"
    }
}