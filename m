From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: the computer hangs when scans the adapter
Message-Id: <3F8F4E5A.5090708@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <JFEPIKOAGNNHNFFLLGAHKEAJCCAA.andywu@iei.com.tw>
In-Reply-To: <JFEPIKOAGNNHNFFLLGAHKEAJCCAA.andywu@iei.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Which motherboard do you have?

Jean Delvare wrote:
>>Hi,
>>I'm using a board with ServerWorks OSB4 and a ADM1026 chip.
>>The computer always hangs here...
>>Next adapter: SMBus PIIX4 adapter at 0580 (Non-I2C SMBus adapter)
>>Do you want to scan it? (YES/no/selectively): YES
>>I'm using Redhat 7.3 with a generic 2.4.18 kernel, and
>>lm_sensors-2.8.1. However, if I add something like "print("$addr");"
>>in the sensors-detect scirpt, it won't hang anymore!
> 
> 
> Strange. Where exactly do you add this line?
> 
> 
>>But still no chip detected.
>>I see no one report this issue on the website.
>>I'm appreciated if you can give me some help or advices.
> 
> 
> If you are sure you have a ServerWorks OSB4 and an ADM1026 chip, you
> could skip the detection step and load i2c-piix4 and adm1026 directly.
> That said, if sensors-detect has difficulties finding the chip, I expect
> that it won't work that easily. Check the logs while inserting the
> modules, it might give you relevant information.
> 
> 



-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
