From: mds@mds.gotdns.com (Mark Studebaker)
Date: Mon, 26 Sep 2005 23:27:44 +0000
Subject: [lm-sensors] [PATCH] fix SW PEC for write byte data
Message-Id: <43386789.3010004@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509240819.AA01317@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200509240819.AA01317@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Konbanwa Hideki,
> 
> 
>>@@ -979,7 +979,7 @@
>> 			break;
>> 		case I2C_SMBUS_BYTE_DATA:
>> 			buf[2] = data->byte;
>>-			data->word = buf[2] ||
>>+			data->word = buf[2] |
>> 			            (i2c_smbus_pec(3, buf, NULL) << 8);
>> 			size = I2C_SMBUS_WORD_DATA;
>> 			break;
> 
> 
> Eek, this one was weird :( Looks like nobody ever used this code.
> Thanks a lot for reporting all these errors in our code. I've committed
> your fix to i2c CVS already and will port it to Linux 2.6 as well.
> 
> Arigato,

ha
of course I take blame and credit for PEC bugs.
PEC really used for block transfers (including ARP and the IPMI-over-I2C_, not familiar with any chip using it
for single bytes.

