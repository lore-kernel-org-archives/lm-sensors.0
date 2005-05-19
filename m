From: jerj@coplanar.net (Jeremy Jackson)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: getting 2.8.7 or better for 2.6 kernel?
Message-Id: <417DA8DA.2030300@coplanar.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4178A7BD.9070607@coplanar.net>
In-Reply-To: <4178A7BD.9070607@coplanar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Well I pulled out the data sheet for pc87364, seems the device 9 index 
0x60 and 0x61 are "base address".  I'm not sure what those are... is 
that an ISA decode address?  Any chance it will work if I set it to any 
random unused address?

Jean Delvare wrote:

> isaset 0x2e 0x2f 7 9
> isaset 0x2e 0x2f 0x30 1 1

-- 
Jeremy Jackson
Coplanar Networks
(519)897-1516
http://www.coplanar.net
