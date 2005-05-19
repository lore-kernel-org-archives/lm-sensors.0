From: slimak@slimak.info (Jan Gorski)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: Configuration info about Asus CUV4x-D
Message-Id: <20050430165120.GA4827@slimak.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
On Asus CUV4X-D (dual PIII mainboard) temperatures of processors reported by
bios are the same as reported by chip without any computation, so you may write
a hint in configuration file.

chip "as99127f-*"

#For Asus CUV4X-D
label temp1 "M/B Temp"
label temp2 "CPU 1"
label temp3 "CPU 2"
compute temp2 @, @
compute temp3 @, @


Pozdrawiam
Slimak (na kraw?dzi)
