struct MockJsonResponse {
    static var success: [[String: Any]] {
        [
            [
                "city": "千代田区",
                "short": "神田まちかど図書館",
                "post": 101-0048,
                "address": "東京都千代田区神田司町2-16 神田さくら館内",
                "primary": 0,
                "formal": "千代田区立神田まちかど図書館",
                "url_pc": "http://www.library.chiyoda.tokyo.jp/",
                "isil": "JP-1000912",
                "faid": "",
                "geocode": "139.7684826,35.6931866",
                "systemid": "Tokyo_Chiyoda",
                "pref": "東京都",
                "libkey": "神田",
                "tel": "03-3256-6061",
                "systemname": "東京都千代田区",
                "distance": 0.117152875277557,
                "libid": "103877",
                "category": "MEDIUM",
            ],
            [
                "distance": 0.4255298617398447,
                "short": "損害保険事業総合研究所",
                "faid": "<null>",
                "libkey": "図書館",
                "pref": "東京都",
                "city": "千代田区",
                "geocode": "139.768156,35.698083",
                "address": "東京都千代田区神田淡路町2丁目9",
                "primary": 0,
                "isil": "JP-1005024",
                "libid": "104964",
                "tel": "03-3255-5513",
                "category": "SPECIAL",
                "systemname": "損保総研図書館",
                "formal": "損害保険事業総合研究所図書館",
                "url_pc": "http://www.sonposoken.or.jp/library",
                "post": "101-8335",
                "systemid": "Special_Sonposoken",
            ],
            [
                "isil": "JP-1003795",
                "primary": 0,
                "faid": "FA006292",
                "category": "UNIV",
                "short": "駿河台図書館",
                "post": "101-8308",
                "url_pc": "http://www.lib.cst.nihon-u.ac.jp/",
                "distance": 0.5303482875804321,
                "city": "千代田区",
                "pref": "東京都",
                "address": "東京都千代田区神田駿河台1-8-14",
                "libid": "107209",
                "formal": "日本大学理工学部駿河台図書館",
                "systemname": "日本大学理工学部",
                "geocode": "139.7636083,35.6976359",
                "systemid": "Univ_Nihon_Rik",
                "tel": "03-3259-0639",
                "libkey": "駿河台図書館",
            ],
            [
                "geocode": "139.763148,35.697670",
                "address": "東京都千代田区神田駿河台1-8-13",
                "libkey": "本館",
                "city": "千代田区",
                "url_pc": "http://www2.dent.nihon-u.ac.jp/library/",
                "primary": 0,
                "isil": "JP-1003800",
                "post": "101-8310",
                "libid": "105593",
                "short": "歯学部分館",
                "systemname": "日本大学歯学部",
                "category": "UNIV",
                "faid": "FA006317",
                "distance": 0.5701365022712462,
                "tel": "03-3219-8006",
                "formal": "日本大学図書館歯学部分館",
                "systemid": "Univ_Nihon_Den",
                "pref": "東京都",
            ],
            [
                "post": "113-8510",
                "url_pc": "http://lib.tmd.ac.jp/",
                "faid": "FA001867",
                "primary": 0,
                "tel": "03-5803-5596",
                "formal": "東京医科歯科大学図書館",
                "systemid": "Univ_Tmd",
                "libid": "105157",
                "isil": "JP-1003336",
                "geocode": "139.7649192,35.7009772",
                "distance": 0.6936910478119368,
                "address": "東京都文京区湯島1丁目5-45",
                "libkey": "本館", "city": "文京区",
                "systemname": "東京医科歯科大学",
                "category": "UNIV",
                "pref": "東京都",
                "short": "図書館",
            ],
        ]
    }

    static var finishSuccess: [String: Any] {
        [
            "session": "asdasdasd",
            "continue": 0,
            "books": [
                "4334926940": [
                    "Univ_Nihon_Den": [
                        "libkey": [:],
                        "reserveurl": "",
                        "status": "Cache",
                    ],
                    "Univ_Tmd": [
                        "libkey": [:],
                        "reserveurl": "",
                        "status": "Cache",
                    ],
                    "Tokyo_Chiyoda": [
                        "libkey": [
                            "千代田": "貸出中",
                            "四番町": "貸出可",
                            "日比谷": "館内のみ",

                        ],
                        "reserveurl": "https://opc.library.chiyoda.tokyo.jp/winj/opac/switch-detail-iccap.do?bibid=1140045479",
                        "status": "Cache",
                    ],
                    "Univ_Nihon_Rik": [
                        "libkey": [
                            "船橋図書館": "予約中",
                        ],
                        "reserveurl": "http://cstlib.cin.nihon-u.ac.jp/opac/opac_details/?lang=0&amode=11&bibid=1000339418",
                        "status": "Cache",
                    ],
                    "Special_Sonposoken": [
                        "libkey": [:],
                        "reserveurl": "",
                        "status": "Cache",
                    ]
                ]
            ]
        ]
    }
}

