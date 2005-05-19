From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: i2c-amd756 and dual opteron sensors not foun
Message-Id: <4040B7DC.8040901@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
In-Reply-To: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Charles,
I agree w/ Khali; we would really like to know what super i/o chip is in there
(w83627thf or ...), if you could look at the board and tell us
that would be a big help.
thanks
mds

Jean Delvare wrote:
>>Thanks so much for the help. I will try get to look at the physical 
>>machine myself this weekend to make sure, but the PDFs  clearly show
>>it being a 8111. I will also look at the bios (i had someone else
>>look before).
> 
> 
> I do not doubt there is a 8111 on-board. The output of "lspci" clearly
> states this. The first question is: why does the smbus part of it
> doesn't show in lspci? The second is: what hardware monitoring chip do
> you have, and were is it located? From our point of view, the 8111 is
> simply a bus. It doesn't provide any sensor value per se.
> 
> Summary (admitting you do have a sensor chip somewhere): either the chip
> is on the 8111 and the challenge is to enable the 8111. Either the chip
> is a Super-I/O or ISA chip, and we need to know what chip it is or we
> cannot do anything.
> 
> Good luck ;)
> 
