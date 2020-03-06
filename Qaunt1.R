library(httr)
library(rvest)
library(readr)

gen_otp_url =
  'http://marketdata.krx.co.kr/contents/COM/GenerateOTP.jspx'
gen_otp_data = list(
  name = 'fileDown',
  filetype = 'csv',
  url = 'MKD/03/0303/03030103/mkd03030103',
  tp_cd = 'ALL',
  date = '20200306',
  lang = 'ko',
  pagePath = '/contents/MKD/03/0303/03030103/MKD03030103.jsp')

otp = POST(gen_otp_url, query = gen_otp_data) %>% read_html() %>% html_text()
otp

down_url = 'http://file.krx.co.kr/download.jspx'
down_sector = POST(down_url, query = list(code = otp), add_headers(referer = gen_otp_url)) %>%
  read_html()%>% html_text()%>% read_csv()
write.csv(down_sector, 'data/krx_sector.csv')
down_sector

spc_otp_url="http://marketdata.krx.co.kr/contents/COM/GenerateOTP.jspx"

spc_otp_data = list(
  name= "filedown",
  filetype = "csv",
  url= "MKD/13/1302/13020401/mkd13020401",
  market_gubun= "ALL",
  gubun= "1",
  isu_cdnm= "A005930/삼성전자",
  isu_cd= "KR7005930003",
  isu_nm="삼성전자",
  isu_srt_cd= "A005930",
  schdate= "20200306",
  fromdate= "20200229",
  todate= "20200305",
  pagePath= "/contents/MKD/13/1302/13020401/MKD13020401.jsp") 

otp_spc = POST(spc_otp_url,query=spc_otp_data) %>% read_html %>% html_text
otp_spc

down_url = "http://file.krx.co.kr/download.jspx"
down_spc = POST(down_url, query=list(code=otp_spc), add_headers(referer = spc_otp_url)) %>% read_html() %>% html_text() %>% read_csv() 
write.csv(down_spc, "data/krx_spc.csv")

library(stringr)
#날짜 가져오기
date_xpath = '//*[@id="frgn_deal_title_tab_0"]/p'
date_url = "https://finance.naver.com/sise/"
biz_date = GET(date_url) %>% read_html(encoding="EUC-KR") %>% html_nodes(xpath=date_xpath) %>% html_text

biz_date
library()
