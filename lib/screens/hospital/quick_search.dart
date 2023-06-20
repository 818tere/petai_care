import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'favorite_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'webVeiw.dart';

class QuickSearch extends StatefulWidget {
  const QuickSearch({super.key});

  @override
  _QuickSearchState createState() => _QuickSearchState();
}

class _QuickSearchState extends State<QuickSearch> {
  final List<Map<String, dynamic>> _allHospitals = [
    {
      "id": 1,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fsearchad-phinf.pstatic.net%2FMjAyMTA5MDdfMjU4%2FMDAxNjMxMDA2ODAxMTQ1.QeVUvRDxTRdoxs9KpC3-pM-P3reoDFCwkT810G8uS8Mg.0Qi786SJGpW9Be3oj1OHb_jGQ0eYZo_i6y9Z-2mD2skg.PNG%2F1262000-79a916e3-13b5-49a2-ab7e-180fff52afd4.png",
      "name": "24시 SNC 동물메디컬센터",
      "number": "02-562-7582",
      "address": "서울 강남구 역삼동",
      "description": "24시간 영업 · 연중무휴",
      "url": "https://m.place.naver.com/place/1056384583/home?entry=pll"
    },
    {
      "id": 2,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fsearchad-phinf.pstatic.net%2FMjAyMjEwMTNfMjcz%2FMDAxNjY1NjUyODU2Nzc5.BbudeR5CtH2t50YkUv0l3ymAKh5IYI2OKm3xYAu07RIg.V8-vPGeI3gfUsKRYG05iXCfEoIqD21NomU9M59ajI78g.PNG%2F2007805-ad777e03-51aa-4b66-8ae8-fe4c7f3e23b3.png",
      "name": "선릉동물병원",
      "number": "0507-1491-1556",
      "address": "서울 강남구 역삼동",
      "description": "9:30 - 21:30 · 일 휴무",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 3,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150831_275%2F14410092946382aozC_JPEG%2FSUBMIT_1386301626194_11631960.jpg",
      "name": "24시청담우리동물병원",
      "number": "0507-1404-7515",
      "address": "서울 강남구 삼성동",
      "description": "24시간 영업 · 연중무휴",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 4,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150831_107%2F1441002422748lybEQ_JPEG%2FSUBMIT_1342622524443_13174703.jpg",
      "name": "예은동물병원",
      "number": "02-529-5575",
      "address": "서울 강남구 역삼동",
      "description": "10:00에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 5,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230131_116%2F1675092539933WKncw_JPEG%2F%25C5%25A9%25B1%25E2%25BA%25AF%25C8%25AF7A8A3433.jpg",
      "name": "스마트 동물병원 신사본원",
      "number": "0507-1406-0275",
      "address": "서울 강남구 신사동",
      "description": "24시간 영업 · 연중무휴",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 6,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150901_277%2F1441063704011tRYCj_JPEG%2F20747335_1.jpg",
      "name": "스마트 동물병원",
      "number": "02-554-7582",
      "address": "서울 강남구 대치동",
      "description": "22:00에 영업 종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 7,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150831_111%2F1440998360944QRumA_JPEG%2FSUBMIT_1359033923575_31498527.jpg",
      "name": "래이동물의료센터",
      "number": "02-556-7588",
      "address": "서울 강남구 대치동",
      "description": "24시간 영업 · 연중무휴",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 8,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fsearchad-phinf.pstatic.net%2FMjAyMjAxMDRfODQg%2FMDAxNjQxMjY3MTMzNDcw.fHrB3KcvxFf3UZhxVAiNE1rzeBPWipfTvyW0k3FxU5Ug.pS8onxVZ4iKv9TbyqJfhqeOpxvFRdscPMATvao85cJ0g.PNG%2F2445042-20cd709e-c5df-4b68-befc-6d46d58408fe.png",
      "name": "커비동물병원",
      "number": "0507-1395-8960",
      "address": "서울 강남구 논현동",
      "description": "10:30에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 9,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fsearchad-phinf.pstatic.net%2FMjAyMjA4MTdfNDIg%2FMDAxNjYwNzAxNjkzNTc4.84wvz8fS-285eFcwNFEkplj8mAH9mYH_qMLQT984GBkg.QYCG60QC4cu84WO0lZJ6Hh5bB5UhYQImzQsRAS5EZLgg.PNG%2F1292029-64cc19f3-9e6d-4441-81ad-1a59f9f897ae.png",
      "name": "예은동물병원",
      "number": "02-529-5575",
      "address": "서울 강남구 역삼동",
      "description": "10:00에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 10,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210420_264%2F1618910667846oSA9R_JPEG%2FV9v-puyT3L1guJk9VvNI6HQM.jpg",
      "name": "VIP동물의료센터 청담점",
      "number": "02-511-7522",
      "address": "서울 강남구 청담동",
      "description": "24시간 영업",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 11,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200808_29%2F1596820244755m8fKV_JPEG%2FLAyMk_Qq25Az9CyG4uB4gZy9.jpg",
      "name": "주주동물종합병원",
      "number": "02-556-0975",
      "address": "서울 강남구 대치동",
      "description": "22:00에 영업 종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 12,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220818_97%2F1660815094340vHkI5_PNG%2F1.png",
      "name": "그레이스동물병원",
      "number": "02-3442-5554",
      "address": "서울 강남구 논현동",
      "description": "10:00에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 13,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20160908_171%2F1473337351836gouzu_JPEG%2F176858615250917_0.jpeg",
      "name": "힐스타동물병원",
      "number": "02-445-5022",
      "address": "서울 강남구 자곡동",
      "description": "21:00에 영업 종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 14,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150831_76%2F1441028975775fnNOh_JPEG%2FSUBMIT_1414487124068_11721589.jpg",
      "name": "이안동물의학센터",
      "number": "02-574-7533",
      "address": "서울 강남구 청담동",
      "description": "21:00에 영업 종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 15,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20160621_39%2F1466497419818VmQ4S_JPEG%2F176565545539699_0.jpeg",
      "name": "청담눈초롱안과동물병원",
      "number": "02-512-7566",
      "address": "서울 강남구 청담동",
      "description": "10:00에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 16,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fsearchad-phinf.pstatic.net%2FMjAyMjEwMjVfMzIg%2FMDAxNjY2Njc3NDE1NzQ0.NPRUOjDSFaqw5hOq_6n1AgvBOL0ovrgDm5RrjTmf6yEg.426DnKRHuYdU22mn0OAMLwfpnpLOngjXb_-x4_T_LZIg.PNG%2F2366294-0d4d1345-e065-4b24-91d1-437572267356.png",
      "name": "24시청담우리동물병원",
      "number": "0507-1404-7515",
      "address": "서울 강남구 삼성동",
      "description": "24시간 영업 · 연중무휴",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 17,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fsearchad-phinf.pstatic.net%2FMjAyMjAxMjZfMjA5%2FMDAxNjQzMTc2MDE0OTMy.K9DnKYeYdSHQIHKljCc6KBIb3oEX7kWhAQDxvqQ_GqUg.b1JobaKwqRfpkspk5FLDjUHMfs7Hto5taHl5LYDTJF8g.PNG%2F2386993-a3e98ea6-2764-4d30-a4c2-e7b5151b23be.png",
      "name": "스마트 동물병원 신사본원",
      "number": "0507-1406-0275",
      "address": "서울 강남구 신사동",
      "description": "24시간 영업 · 연중무휴",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 18,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210918_185%2F1631944977442Y11ek_JPEG%2FvNir-vzhKH0Fn-62VEDlxe7C.jpg",
      "name": "OK동물병원",
      "number": "02-569-7582",
      "address": "서울 강남구 역삼동",
      "description": "09:00에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 19,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200410_35%2F1586512994898LtxFI_JPEG%2F3yreVWme5aqB58Nwa_PGAxGa.jpg",
      "name": "충현동물종합병원",
      "number": "02-549-7582",
      "address": "서울 강남구 논현동",
      "description": "언주역 2번 출구 175m",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 20,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210512_198%2F16208184572478GNhI_JPEG%2FmjLIXtJM7P6pYmLOsF3846qR.JPG.jpg",
      "name": "아이윌24시동물병원",
      "number": "02-6925-7021",
      "address": "서울 강남구 청담동",
      "description": "24시간 영업 · 연중무휴",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 21,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220908_66%2F1662622045788AyVcl_JPEG%2F%25B5%25E5%25B8%25B2%25B5%25BF%25B9%25B0%25BA%25B4%25BF%25F8_%25B7%25CE%25B0%25ED.jpg",
      "name": "드림 동물병원",
      "number": "02-508-7583",
      "address": "서울 강남구 역삼동",
      "description": "10:00에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 22,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210710_115%2F1625851693461glsim_JPEG%2FtT5V2S3mLHhlJytFB77aRJiF.jpg",
      "name": "아크리스동물의료센터",
      "number": "02-583-7582",
      "address": "서울 강남구 삼성동",
      "description": "10:00에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 23,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230223_189%2F1677120686924hxbwK_JPEG%2F53A2653E-8487-453B-A402-7492F35C1559.jpeg",
      "name": "라퓨클레르 동물피부클리닉",
      "number": "0507-1480-0937",
      "address": "서울 강남구 청담동",
      "description": "13:00에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 24,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fsearchad-phinf.pstatic.net%2FMjAyMjA4MzBfNTEg%2FMDAxNjYxODU3MDc1NTcx.A2t49wjVYEKICklQWXiyhs6Hw_KskPAMvKy9Vp0bYaIg.LwKDuGvQdtrNkLHQNNmRiX2YNAx9ZlT-TKdkqb_AMYwg.PNG%2F2493651-c0b9efbd-d860-4c89-a023-f882557a16a6.png",
      "name": "그레이스동물병원",
      "number": "02-3442-5554",
      "address": "서울 강남구 논현동",
      "description": "10:00에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 25,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fsearchad-phinf.pstatic.net%2FMjAyMTA2MjlfNDkg%2FMDAxNjI0OTQxOTc4NDk2.nDTzhyqkVZvKUCJc031RzQbr0Oy_HIHJMUuzklMdzucg._uZ40eGvNtoeFyfO4CLF9yE6uOcVPlEYYVdUqmGLb_Eg.PNG%2F1603148-00afb668-0178-42bf-88d0-0d75f27b9175.png",
      "name": "하나카동물병원",
      "number": "0507-1409-5852",
      "address": "서울 강남구 역삼동",
      "description": "10:00에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 26,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20160108_288%2F14522221820093BdWW_JPEG%2F176054556335882_0.jpeg",
      "name": "와이즈24시동물병원",
      "number": "0507-1408-8253",
      "address": "서울 강남구 논현동",
      "description": "09:30에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 27,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20160219_2%2F1455876443770cyOMg_JPEG%2F176169593743597_0.jpeg",
      "name": "논현동물병원",
      "number": "02-3442-3785",
      "address": "서울 강남구 논현동",
      "description": "24:00에 영업 종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 28,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200408_150%2F1586326650611Rrq8J_JPEG%2FuuJp7EgAc5uTd46nc-zF_39R.jpeg.jpg",
      "name": "이비치동물치과병원",
      "number": "02-511-2842",
      "address": "서울 강남구 청담동",
      "description": "09:00에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 29,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200922_258%2F160070664706221HS5_JPEG%2FGXtevNL6c7H-GDlg0hHcSyST.jpg",
      "name": "커비동물병원",
      "number": "0507-1395-8960",
      "address": "서울 강남구 논현동",
      "description": "10:30에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 30,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20161019_132%2F1476841572179oCSUw_JPEG%2F176969507630673_2.jpeg",
      "name": "츄츄동물병원",
      "number": "02-512-0075",
      "address": "서울 강남구 역삼동",
      "description": "09:30에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 31,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200509_35%2F1588983348816Ww7eP_JPEG%2FmNyvLb_SRdrMua5YzKGiZEBA.jpg",
      "name": "최영민동물의료센터",
      "number": "0507-1312-9539",
      "address": "서울 강남구 논현동",
      "description": "10:00에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 32,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fsearchad-phinf.pstatic.net%2FMjAyMzAxMTFfMTIy%2FMDAxNjczNDAwNTIxNDc0.Z3oijMlOlEWm8xRD2VDRkQPyWK_E3NyQN4y8Evlso3kg.MrO0h5ZuQfxceeyN0TXPFhmoOkua-AGbW15se5rp6Kog.PNG%2F1320435-e5d025f8-acc5-446e-9969-f83d99a042d2.png",
      "name": "순수동물병원",
      "number": "02-515-8575",
      "address": "서울 강남구 논현동",
      "description": "10:00에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 33,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fsearchad-phinf.pstatic.net%2FMjAyMTExMThfOTEg%2FMDAxNjM3MjEzODE1MzA0.Bi-SU3uXkmrrePi2nZsF2i09vwUQMUu4R5813o9_g1kg.b-Qj0FBR395PIE99GtTllx4sAyIhnZB_H6hYhMsUW-Ig.PNG%2F2407808-464ac32f-f54f-439b-9831-f93824eda6e6.png",
      "name": "강남예치과동물병원",
      "number": "02-517-5585",
      "address": "서울 강남구 삼성동",
      "description": "09:30에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 34,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220705_123%2F1657006169462gLMgl_PNG%2F%25C1%25B6%25C8%25F1%25C1%25F8%25B4%25D4_2-blur-gold.png",
      "name": "청담리덴 동물치과병원",
      "number": "0507-1436-2884",
      "address": "서울 강남구 청담동",
      "description": "매주 월요일 휴무",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 35,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20180327_204%2F1522134601158fthnB_JPEG%2FbkDsQ1nrrvKxpXN6s5qeKMHZ.JPG.jpg",
      "name": "고려종합동물병원",
      "number": "02-575-7999",
      "address": "서울 강남구 도곡동",
      "description": "10:00에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 36,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20180726_180%2F1532582394936thXVU_JPEG%2FeGmiqaRGYL_QBCWG35BY8xUt.JPG.jpg",
      "name": "신사동물병원",
      "number": "02-549-4505",
      "address": "서울 강남구 논현동",
      "description": "22:00에 영업 종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 37,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20160829_261%2F1472465288183aLktj_JPEG%2F176779593826076_0.jpeg",
      "name": "서울동물심장병원",
      "number": "0507-1438-7588",
      "address": "서울 강남구 역삼동",
      "description": "선정릉역 4번 출구 651m",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 38,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20180829_80%2F1535504437088Gd1VG_JPEG%2FJSmcS3msPB1bSq3Mc5548VZP.jpg",
      "name": "치료멍멍동물병원 신사본원",
      "number": "02-545-0075",
      "address": "서울 강남구 신사동",
      "description": "10:00에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 39,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150909_242%2F1441767398064ERx6j_PNG%2FSUBMIT_1441767296226_36823717.png",
      "name": "압구정웰동물병원",
      "number": "0507-1420-0275",
      "address": "서울 강남구 신사동",
      "description": "10:00에 영업 시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 40,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fsearchad-phinf.pstatic.net%2FMjAyMzAyMTNfMTk1%2FMDAxNjc2MjYyNjU2NTU4.zzhTXW-Xu07qheyN5rKgZ5QSbVmoYxrPDiEF5YDtPu0g.CZu4G0cP1fvmA1bCA0eZIQfrQVlKN6lgxlc13ddUHmMg.PNG%2F2719678-e1722883-83aa-42fd-a2aa-206ea4d5d6a5.png",
      "name": "아이안 동물의료센터",
      "number": "0507-1354-2203",
      "address": "서울 강동구 명일동",
      "description": "21:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 41,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fsearchad-phinf.pstatic.net%2FMjAyMjAxMDVfMjcg%2FMDAxNjQxMzY3MjY1MjQ3.vLjYus18hAxTaWxZxIOSyrqLKMHKtMvNrhIgnY2kKIsg.MhWWDIhLprDbE0Ou1FADpmzoSF80_oYZfl8FvnRb-PIg.PNG%2F2294240-e051296b-436e-418d-a3ec-5327266cfe9d.png",
      "name": "메이플동물의료센터",
      "number": "0507-1486-7979",
      "address": "서울 강동구 강일동",
      "description": "09:30에 영업시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 42,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150901_86%2F1441119539372g0tXD_JPEG%2F35021518_0.jpg",
      "name": "내품에동물병원",
      "number": "02-477-1775",
      "address": "서울 강동구 성내3동",
      "description": "21:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 43,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220108_82%2F1641635686429XErV6_JPEG%2F20220105_174624.jpg",
      "name": "석동물병원",
      "number": "02-475-7501",
      "address": "서울 강동구 성내동",
      "description": "19:10에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 44,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200606_228%2F1591431943781sgLw5_JPEG%2F-FvnrgivR3wjZJIPGQGqCSzP.jpg",
      "name": "박형우동물병원",
      "number": "02-488-8275",
      "address": "서울 강동구 성내동",
      "description": "강동구청역 1번출구",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 45,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20190414_205%2F1555245298076F9bla_JPEG%2FUJpSINKUywU86ANwNGWxvB0E.jpg",
      "name": "아프리카동물병원",
      "number": "02-426-7722",
      "address": "서울 강동구 강일동",
      "description": "19:30에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 46,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20170727_87%2F1501081256638NcQwB_PNG%2F186677403076504_0.png",
      "name": "강동24시SKY동물의료센터",
      "number": "02-472-7579",
      "address": "서울 강동구 성내동",
      "description": "24시간 영업 연중무휴",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 47,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220714_255%2F1657736483253t81A9_JPEG%2F00440B85-50A3-48B9-B784-3EAE2251C4A7.jpeg",
      "name": "24시 더파크동물의료센터",
      "number": "02-6949-2475",
      "address": "서울 강동구 성내동",
      "description": "24시간 영업 연중무휴",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 48,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150901_254%2F1441096224949WzMvF_JPEG%2FSUBMIT_1433755631838_36768383.jpg",
      "name": "고덕24시동물병원",
      "number": "0507-1463-8278",
      "address": "서울 강동구 명일동",
      "description": "24시간 영업 연중무휴",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 49,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200301_277%2F1583007612901dwTiS_JPEG%2FqCUNkIuOXeevstKzqjpPcrZL.jpg",
      "name": "스마트동물병원 강동암사점",
      "number": "0507-1402-8875",
      "address": "서울 강동구 암사동",
      "description": "20:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 50,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20190821_93%2F1566375076556SSBOv_JPEG%2FQ_TNJByc-EcbIY_kKK0h_M6d.jpeg.jpg",
      "name": "올바른동물병원",
      "number": "0507-1421-1661",
      "address": "서울 강동구 암사동",
      "description": "09:30~21:00",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 51,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210706_92%2F1625550033498borlO_JPEG%2Fcy6qqxcdFu8r7AuOqYJZp3z5.jpg",
      "name": "로얄동물메디컬센터 강동",
      "number": "02-457-0075",
      "address": "서울 강동구 길동",
      "description": "24시간 영업 연중무휴",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 52,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150901_134%2F1441098465474ARneO_JPEG%2F166560567128098_0.jpeg",
      "name": "가람동물병원",
      "number": "0507-1412-5502",
      "address": "서울 강동구 성내동",
      "description": "20:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 53,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20170728_141%2F1501245049098qQ6wO_JPEG%2F186678616067619_0.jpeg",
      "name": "고래힐동물병원",
      "number": "0507-1447-5515",
      "address": "서울 강동구 고덕동",
      "description": "10:00~22:00",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 54,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20190402_40%2F1554171400129RH3x7_JPEG%2FD5Ea8qeTCKyY6tsEjUROJjJ9.jpg",
      "name": "씨에이치동물병원",
      "number": "0507-1358-7510",
      "address": "서울 강동구 천호동",
      "description": "20:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 55,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200707_23%2F1594119174851fXq9H_JPEG%2FEF-CEDRBor9n8ZBe4NuYJyXw.jpg",
      "name": "미드미동물의료센터",
      "number": "02-6497-7582",
      "address": "서울 강동구 명일동",
      "description": "20:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 56,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220224_290%2F1645694928325e5mMW_JPEG%2FKakaoTalk_20220224_182616088.jpg",
      "name": "돌봄 동물병원",
      "number": "0507-1398-2775",
      "address": "서울 강동구 암사동",
      "description": "20:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 57,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200429_87%2F1588117722700bpAMU_JPEG%2F4WLpvapSRkzb742deE4DpjxX.jpeg.jpg",
      "name": "둔촌동물병원",
      "number": "02-474-5100",
      "address": "서울 강동구 성내동",
      "description": "22:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 58,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20211117_247%2F1637128122263BOvS3_JPEG%2F1637127831919-1.jpg",
      "name": "고덕 동물의료센터",
      "number": "02-441-7585",
      "address": "서울 강동구 고덕동",
      "description": "20:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 59,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200314_107%2F1584178962399O58qT_JPEG%2FVY9xHrvhe0z6GCk9bMbcluCm.jpg",
      "name": "펫트리동물의료센터",
      "number": "0507-1310-5775",
      "address": "서울 강동구 길동",
      "description": "21:30에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 60,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20221215_223%2F1671076691211wwzBl_JPEG%2F20210927-141810.jpg",
      "name": "안단테동물병원",
      "number": "02-476-7582",
      "address": "서울 강동구 천호동",
      "description": "20:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 61,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200716_116%2F1594876567512NW2tF_JPEG%2FLxI7z6PrkdcGRZeXjt7AJ6vW.jpg",
      "name": "시온동물병원",
      "number": "02-476-8275",
      "address": "서울 강동구 천호동",
      "description": "10:00에 영업시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 62,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20180508_298%2F1525751105367zhPW9_JPEG%2FOnDXBCHupjpJxiKygE43gfo6.jpg",
      "name": "동물병원 공감",
      "number": "0507-1419-7975",
      "address": "서울 강동구 천호동",
      "description": "20:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 63,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150831_172%2F1441015060050Aufo4_JPEG%2F11669717_0.jpg",
      "name": "정동물병원",
      "number": "02-474-7588",
      "address": "서울 강동구 천호동",
      "description": "19:30에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 64,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20190823_240%2F1566546102777UAw8J_JPEG%2FyX9W6NSTpE2Yhjdwl_XBgUAD.jpg",
      "name": "해태동물병원",
      "number": "02-427-5685",
      "address": "서울 강동구 명일동",
      "description": "20:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 65,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230213_77%2F1676264367432mdMMI_JPEG%2F1676264289365-1.jpg",
      "name": "센트럴동물병원",
      "number": "02-3428-0045",
      "address": "서울 강동구 고덕동",
      "description": "20:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 66,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20161213_85%2F14815965531746yYWQ_GIF%2F177163516572148_0.gif",
      "name": "마리스동물의료센터",
      "number": "02-442-8287",
      "address": "서울 강동구 암사동",
      "description": "21:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 67,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200625_178%2F1593052356089XM9O4_JPEG%2F4Gwwya1CuxWhju6qyaIfb_7q.jpg",
      "name": "가온동물병원",
      "number": "02-6953-7512",
      "address": "서울 강동구 고덕동",
      "description": "21:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 68,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F%2F20170125_151%2F1485351449569Nho3w_JPEG%2F1485350630321.jpg",
      "name": "닥터표동물병원",
      "number": "0507-1407-4063",
      "address": "서울 강동구 성내동",
      "description": "20:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 69,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20190524_149%2F15586337439625a40a_JPEG%2F_gbZy0uAhmJVIAa3XXxRcfBG.jpg",
      "name": "쥬라기동물병원",
      "number": "02-488-7463",
      "address": "서울 강동구 천호동",
      "description": "10:00에 영업시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 70,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20190814_157%2F1565743581519E1VcK_JPEG%2F7mDC4NnuQulte1MUG_7is9tn.jpg",
      "name": "양지가축동물병원",
      "number": "02-478-2208",
      "address": "서울 강동구 길동",
      "description": "10:00~18:00",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 71,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20201024_127%2F16035075711102pxay_JPEG%2FAZTy5d3GWwhFXQlZY0P-7KyU.jpg",
      "name": "사랑동물병원",
      "number": "0507-1322-1750",
      "address": "서울 강동구 길동",
      "description": "10:00에 영업시작",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 72,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210223_246%2F1614047321649pf5Pa_JPEG%2FKYZ2pzO7lc9YoLFt5TlrbG_I.jpeg.jpg",
      "name": "암사동물병원",
      "number": "02-3426-5079",
      "address": "서울 강동구 암사동",
      "description": "20:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 73,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20160624_244%2F1466734688886QkGsX_JPEG%2F176574514828803_0.jpeg",
      "name": "방주동물의료센터",
      "number": "02-476-3927",
      "address": "서울 강동구 성내동",
      "description": "09:30~19:30",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 74,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150902_108%2F14411256878002T1Uh_JPEG%2FSUBMIT_1425016815165_35125616.jpg",
      "name": "Dr.주 동물병원",
      "number": "02-470-0030",
      "address": "서울 강동구 둔촌동",
      "description": "둔촌동역 1번출구",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 75,
      "imageUrl":
          "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200319_71%2F1584554959576bWFQc_JPEG%2F6Kyk7PdQz-Q3GXUivMqO6GSv.jpg",
      "name": "두루동물병원",
      "number": "02-442-7772",
      "address": "서울 강동구 명일동",
      "description": "20:00에 영업종료",
      "url":
          "https://map.naver.com/v5/entry/place/1056384583?lng=127.0388137&lat=37.4973981&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh"
    },
    {
      "id": 76,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200626_300%2F1593150242771KXWVK_JPEG%2FRtr19BTsKRQtIc08qqN5e7Ud.jpg",
      "name": "바른마음동물병원",
      "number": "0507-1316-7512",
      "address": "시흥 능곡동",
      "description": "10:00에 영업시작",
      'url': "https://m.place.naver.com/place/1943524026/home?entry=pll",
    },
    {
      "id": 77,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210913_30%2F16315050083578pelg_JPEG%2FVpvxnMCIpB0kg7L1NGTIuXd7.jpg",
      "name": "24시 스마트 동물의료센터",
      "number": "031-432-1224",
      "address": "시흥 배곧동",
      "description": "24시간 영업 연중무휴",
      'url': "https://m.place.naver.com/place/1532423448/home?entry=pll",

    },
    {
      "id": 78,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20170818_52%2F1503055849600F3c25_JPEG%2FU5ft02v8nnXZs_gtT_2yHIZR.jpeg.jpg",
      "name": "배곧동물병원",
      "number": "0507-1411-6611",
      "address": "시흥 배곧동",
      "description": "09:00에 영업 시작",
      'url': "https://m.place.naver.com/place/1665633549/home?entry=pll",
    },
    {
      "id": 79,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220321_126%2F1647870768766PWcCn_JPEG%2F%25C0%25CC%25BB%25EA%25B5%25BF%25B9%25B0%25C0%25C7%25B7%25E1%25BC%25BE%25C5%25CD_66.jpg",
      "name": "이산동물의료센터",
      "number": "0507-1358-6536",
      "address": "시흥 능곡동",
      "description": "09:30에 영업 시작",
      'url': "https://m.place.naver.com/place/1054391790/home?entry=pll",
    },
    {
      "id": 80,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20190509_188%2F1557327682525Czhwq_JPEG%2FNb_ioP9phFRI1l7afPMv0nYS.jpg",
      "name": "고래동물병원",
      "number": "031-505-7588",
      "address": "시흥 은행동",
      "description": "10:00에 영업 시작",
      'url': "https://m.place.naver.com/place/1804566080/home?entry=pll",
    },
    {
      "id": 81,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20191113_248%2F1573625307602lCNRo_JPEG%2FZLcbK1GIlHd0NRukAP_Z4wb8.jpg",
      "name": "참누리종합동물병원",
      "number": "031-312-0075",
      "address": "시흥 대야동",
      "description": "시흥대야역 2번 출구",
      'url': "https://m.place.naver.com/place/37383885/home?entry=pll",
    },
    {
      "id": 82,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200814_281%2F15973707498691emha_JPEG%2F7LglUyoXEWgofJnqn9JEbjaw.jpg",
      "name": "시화종합동물병원",
      "number": "031-507-0082",
      "address": "시흥 정왕동",
      "description": "10:00 - 19:30",
      'url': "https://m.place.naver.com/place/11643918/home?entry=pll&zoomLevel=13.000",
    },
    {
      "id": 83,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220602_134%2F1654179246792hrthT_JPEG%2Fimg_%25284%2529.jpg",
      "name": "동그라미동물의료센터",
      "number": "0507-1403-0136",
      "address": "시흥 장곡동",
      "description": "10:00에 영업 시작",
      'url': "https://m.place.naver.com/place/1041013980/home?entry=pll",
    },
    {
      "id": 84,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200324_285%2F1585037296339Cb2Pa_JPEG%2F9bgowViWrZB2raRdk5OlKtOZ.jpg",
      "name": "내친구동물병원",
      "number": "031-497-4479",
      "address": "시흥 배곧동",
      "description": "10:00에 영업 시작",
      'url': "https://m.place.naver.com/place/1927671881/home?entry=pll",
    },
    {
      "id": 85,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150901_134%2F1441033336012gRlXr_JPEG%2FSUBMIT_1435302075169_13412585.jpg",
      "name": "이지종합동물병원",
      "number": "0507-1394-7975",
      "address": "시흥 대야동",
      "description": "10:30에 영업 시작",
      'url': "https://m.place.naver.com/place/13412585/home?entry=pll",
    },
    {
      "id": 86,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220414_145%2F1649943809402pvgM3_JPEG%2F3%25BF%25DC%25BA%25CE%25C0%25FC%25B0%25E61.JPG",
      "name": "24시 센트럴동물의료센터",
      "number": "031-432-2475",
      "address": "시흥 정왕동",
      "description": "24시간 영업 연중무휴",
      'url': "https://m.place.naver.com/place/1393893257/home?entry=pll",
    },
    {
      "id": 87,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200516_20%2F15895954589250VhYS_JPEG%2FyyWxzkqVmaZz4ern1jNUfQs7.jpg",
      "name": "배곧도담동물병원",
      "number": "031-499-3007",
      "address": "시흥 배곧동",
      "description": "10:00에 영업 시작",
      'url': "https://m.place.naver.com/place/1330849126/home?entry=pll",
    },
    {
      "id": 88,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200810_69%2F1597036781109vcxfc_JPEG%2FWBZWFPExcWsVWAor57wPison.jpg",
      "name": "24시위드유동물의료센터",
      "number": "0507-1353-4975",
      "address": "시흥 은행동",
      "description": "09:00 - 20:00",
      'url': "https://m.place.naver.com/place/1679686416/home?entry=pll",
    },
    {
      "id": 89,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220831_7%2F1661923737337amhT4_JPEG%2Fedit-32.jpg",
      "name": "더좋은동물병원",
      "number": "031-431-0075",
      "address": "시흥 배곧동",
      "description": "10:00에 영업 시작",
      'url': "https://m.place.naver.com/place/1390505216/home?entry=pll",
    },
    {
      "id": 90,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230120_11%2F1674213658422FByqy_JPEG%2F%25C5%25BE%25B5%25BF%25B9%25B0%25BA%25B4%25BF%25F8_28.jpg",
      "name": "시흥탑동물의료센터",
      "number": "031-316-0750",
      "address": "시흥 은행동",
      "description": "10:00에 영업 시작",
      'url': "https://m.place.naver.com/place/1374032487/home?entry=pll",
    },
    {
      "id": 91,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20221123_185%2F1669173517779hgAHI_JPEG%2FKakaoTalk_20221123_120914897_03.jpg",
      "name": "비타민동물병원",
      "number": "0507-1457-9120",
      "address": "시흥 배곧동",
      "description": "10:00에 영업 시작",
      'url': "https://m.place.naver.com/place/1697864313/home?entry=pll",
    },
    {
      "id": 92,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20190130_3%2F15488289977366k98x_JPEG%2FsQCx3L9qM9IFWt4PJpf4nYYU.jpeg.jpg",
      "name": "목감시티동물병원",
      "number": "031-504-7559",
      "address": "시흥 조남동",
      "description": "09:00 - 20:00",
      'url': "https://m.place.naver.com/place/1750219046/home?entry=pll",
    },
    {
      "id": 93,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20201102_296%2F1604306468932noSby_JPEG%2FkU_ETfmAgyPWBI8TUkhxvaKT.jpg",
      "name": "박한준종합동물병원",
      "number": "031-315-7582",
      "address": "시흥 대야동",
      "description": "09:00에 영업 시작",
      'url': "https://m.place.naver.com/place/11846128/home?entry=pll",
    },
    {
      "id": 94,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210720_141%2F1626756944325mflaB_JPEG%2F2hadVC22erSwCoabUWzQ-ro7.jpeg.jpg",
      "name": "시흥i동물병원",
      "number": "031-8042-7511",
      "address": "시흥 대야동",
      "description": "09:30에 영업 시작",
      'url': "https://m.place.naver.com/place/1083401783/home?entry=pll",
    },
    {
      "id": 95,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200403_78%2F15858857462311eetH_JPEG%2Foe7PurbgiLpQXEl_SUOMiJKV.jpg",
      "name": "만세동물병원",
      "number": "0507-1316-7583",
      "address": "시흥 배곧동",
      "description": "10:30에 영업 시작",
      'url': "https://m.place.naver.com/place/1699622449/home?entry=pll&zoomLevel=13.000",
    },
    {
      "id": 96,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210628_80%2F1624863154684QVPMD_JPEG%2FrdFwhp1jsm7VfKpdzYaOH_M6.jpg",
      "name": "윤슬동물병원",
      "number": "031-404-8566",
      "address": "시흥 월곶동",
      "description": "10:00에 영업 시작",
      'url': "https://m.place.naver.com/place/1505097923/home?entry=pll",
    },
    {
      "id": 97,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220607_67%2F1654587389091BMpcs_JPEG%2FKakaoTalk_20220603_095715426_02.jpg",
      "name": "연희동물의료원",
      "number": "0507-1445-5119",
      "address": "시흥 장곡동",
      "description": "10:00에 영업 시작",
      'url': "https://m.place.naver.com/place/1163647409/home?entry=pll",
    },
    {
      "id": 98,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200719_179%2F1595146830074N9UD8_JPEG%2F5QTuRZ5goqsvJ6gyZ4a-CEgx.jpg",
      "name": "위드동물병원",
      "number": "0507-1323-8075",
      "address": "시흥 정왕동",
      "description": "10:00에 영업 시작",
      'url': "https://m.place.naver.com/place/37179512/home?entry=pll",
    },
    {
      "id": 99,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200308_294%2F1583637011882Yh4kW_JPEG%2Ffpea-Vi-FV3TCLihMpb_FViA.jpg",
      "name": "은계동물병원",
      "number": "031-315-7588",
      "address": "시흥 은행동",
      "description": "09:30에 영업 시작",
      'url': "https://m.place.naver.com/place/1548236677/home?entry=pll",
    },
    {
      "id": 100,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20191112_249%2F1573542697156J8GtY_JPEG%2FQNfy8DGXXG9Oq_57QpnZaXNg.jpg",
      "name": "푸른동물병원",
      "number": "031-404-7588",
      "address": "시흥 은행동",
      "description": "경기 시흥시 은행로 130",
      'url': "https://m.place.naver.com/place/17901475/home?entry=pll&zoomLevel=13.000",
    },
    {
      "id": 101,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20190128_13%2F1548678015995WHFkA_JPEG%2FfB7yqKCpPgspZRX2luCcQlKo.jpg",
      "name": "배곧 코코동물병원",
      "number": "031-434-0863",
      "address": "시흥 정왕동",
      "description": "10:00에 영업 시작",
      'url': "https://m.place.naver.com/place/37673502/home?entry=pll",
    },
    {
      "id": 102,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200727_187%2F1595826492647AQIkl_JPEG%2FV7RXhy35yLhPr37g1qvjQMxz.jpg",
      "name": "펫츠나라동물병원",
      "number": "031-314-0706",
      "address": "시흥 신천동",
      "description": "10:00에 영업 시작",
      'url': "https://m.place.naver.com/place/19898918/home?entry=pll",
    },
    {
      "id": 103,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20190130_97%2F1548827473063iIOVm_JPEG%2F3tA7gLbU2D9EhfjhbL4XB9Jm.jpg",
      "name": "능곡동물병원",
      "number": "031-317-7234",
      "address": "시흥 능곡동",
      "description": "09:30에 영업 시작",
      'url': "https://m.place.naver.com/place/19574564/home?entry=pll&zoomLevel=14.000",
    },
    {
      "id": 104,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20170307_234%2F1488846833663MLneC_JPEG%2F186257496372684_0.jpeg",
      "name": "정다운동물병원",
      "number": "031-498-7582",
      "address": "시흥 정왕동",
      "description": "010:00에 영업 시작",
      'url': "https://m.place.naver.com/place/17939582/home?entry=pll",
    },
    {
      "id": 105,
      "imageUrl":
          "https:\/\/search.pstatic.net\/common\/?autoRotate=true&quality=95&type=f184_184&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200411_299%2F1586579771707LOrhu_JPEG%2FhZChbMNEjq-97n6UJPBLuRR0.jpg",
      "name": "청안동물병원",
      "number": "031-311-4148",
      "address": "시흥 신천동",
      "description": "신천역 5번 출구",
      'url': "https://m.place.naver.com/place/17892643/home?entry=pll&zoomLevel=14.000",
    }
  ];

  List<Map<String, dynamic>> _foundHospitals = [];

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    _foundHospitals = _allHospitals;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allHospitals;
    } else {
      results = _allHospitals
          .where((hospital) =>
              hospital["address"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              hospital["name"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundHospitals = results;
    });
  }

  void showPopup(context, imageUrl, name, address, number, description) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 380,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                        image: NetworkImage(imageUrl.toString()),
                        fit: BoxFit.fill),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    address,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    number,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              )),
        );
      },
    );
  }

  Map<String, String> headerss = {
    "X-NCP-APIGW-API-KEY-ID": "c3oxeg0m2z", // 네이버 지도 api 개인 클라이언트 아이디
    "X-NCP-APIGW-API-KEY":
        "Zme14LJePwVAkOFV5ur1vnJog3FexA1UvGxDegFz" // 개인 시크릿 키
  };

  String myLocation = "";

  Future<List> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String lat = position.latitude.toString();
    String lon = position.longitude.toString();
    Response response = await get(
        Uri.parse(
            'https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=$lon,$lat&sourcecrs=epsg:4326&output=json'),
        headers: headerss);
    String jsonData = response.body;
    var myjsonGu =
        jsonDecode(jsonData)["results"][1]['region']['area2']['name'];
    var myjsonSi =
        jsonDecode(jsonData)["results"][1]['region']['area1']['name'];

    List<String> gusi = [myjsonSi, myjsonGu];

    return gusi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '동물병원',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextField(
            controller: controller,
            onChanged: (value) => _runFilter(value),
            decoration: const InputDecoration(
              hintText: '   지역명, 병원명 검색',
              suffixIcon: Icon(Icons.search),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.shade300,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton.icon(
              onPressed: () {
                getLocation().then(
                  (value) {
                    myLocation = value[1];
                    controller.text = myLocation;
                    _runFilter(myLocation);
                  },
                );
              },
              icon: const Icon(Icons.location_on_sharp),
              label: const Text('내 주변 병원 찾기',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade100,
                foregroundColor: Colors.grey.shade800,
                elevation: 0,
                fixedSize: const Size(double.maxFinite, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<FavoriteItemProvider>(
              builder: (context, favoriteProvider, child) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _foundHospitals.length,
                  itemBuilder: (context, index) {
                    final hospital = _foundHospitals[index];
                    final hospitalId = hospital["id"];
                    final isFavorite =
                        favoriteProvider.selectedItem.contains(hospitalId);

                    return Card(
                      key: ValueKey(hospitalId),
                      color: Colors.white,
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              hospital['name'],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                if (isFavorite) {
                                  favoriteProvider.removeItem(hospitalId);
                                } else {
                                  favoriteProvider.addItem(hospitalId);
                                }
                              },
                            ),
                          ],
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  hospital['address'],
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xffF9DEDC),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 55, vertical: 10)),
                                  onPressed: () async {
                                    final phoneNumber = hospital['number'];
                                    await launch("tel://$phoneNumber");
                                  },
                                  child: const Text('전화 걸기',
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade100,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 55, vertical: 10),
                                  ),
                                  onPressed: () {
                                    final hospitalUrl = hospital['url'];
                                    _navigateToWebView(context, hospitalUrl);
                                  },
                                  child: const Text(
                                    '병원 정보',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _navigateToWebView(BuildContext context, String url) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => WebViewScreen(url: url),
    ),
  );
}
