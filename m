From: jerj@coplanar.net (Jeremy Jackson)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: getting 2.8.7 or better for 2.6 kernel?
Message-Id: <417DAC8D.1020000@coplanar.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4178A7BD.9070607@coplanar.net>
In-Reply-To: <4178A7BD.9070607@coplanar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Well setting base address to 0x0380 lets the module load.  Not much 
happens yet though, next i'll update the patch to the last one you sent.

so i added

isaset 0x2e 0x2f 0x60 0x03
isaset 0x2e 0x2f 0x61 0x80

Jean Delvare wrote:
> 
> isaset 0x2e 0x2f 7 9
> isaset 0x2e 0x2f 0x30 1 1
> 
> Then loading the driver should work. Whether or not you will find it
> useful on your board, you tell us.

-- 
Jeremy Jackson
Coplanar Networks
(519)897-1516
http://www.coplanar.net
