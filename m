From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: I-Buttons
Message-Id: <3E9DF238.4060602@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c30458$e77ce120$0201000a@ulisoft.net>
In-Reply-To: <000001c30458$e77ce120$0201000a@ulisoft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Sorry for the confusion, I think the 1-wire stuff are the chips and 
components used to implement the iButton systems?  The 1-wire bus host 
chips come in the same flavors as the ready-to-use iButton interfaces 
(serial, usb, parallel port, etc.):

http://para.maxim-ic.com/compare.asp?Fam=1Wire&Tree=1Wire&HP=1-Wire.cfm&ln
All of those flavors, including the usb, could most easily be implmented 
in user-space, I'm thinking (makes debugging easier!).


Phil

Ulrich Moshammer wrote:

> I have also implemented the I-Buttons but I will not implement the 
> I-Buttons I will implement the one wire bus. For the one wire bus 
> there are temperature sensors in TO92 package or SOT package 
> available. This is my main reason to build a kernel driver.
>
>  
>
