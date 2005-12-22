From: DOSProfi@web.de (Enrico Bartky)
Date: Thu, 22 Dec 2005 17:38:06 +0000
Subject: [lm-sensors] PC87591x
Message-Id: <43AAE47E.6070508@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <42418B75.3080707@web.de>
In-Reply-To: <42418B75.3080707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have (new?) information about the PC87591x Super-I/O Chip. I have 
talked to Winbond and they said, the only way to access this chip is 
through the PowerManagement channels. The problem is, there exists 
verious firmware implementations, so (I think) there exists different 
commands through these channels.

To support this chip, there are 2 possibilities. The first is we need to 
develope a firmware. The second is to analyze the firmware. On the 
Uniwill website, there is a reader/writer for this chip 
(http://www.uniwill.com/UserDownload/N243S/N243S2.htm), included in the 
BIOS Update archive and is called ecf11t.exe. And on National's page 
there is a programming reference for the core of the chip (CR16B). The 
datasheet is available at 
http://www.national.com/appinfo/compactrisc/pdf/cr16b-prog-ref.pdf.

Have anyone an idea, how to proceed the support? I know, none of these 
possibilities are easy to manage.

EnricoB


