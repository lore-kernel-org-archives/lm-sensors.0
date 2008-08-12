From: Wolfgang Grandegger <wg@grandegger.com>
Date: Tue, 12 Aug 2008 08:55:58 +0000
Subject: Re: [lm-sensors] New style driver for w83781d?
Message-Id: <48A1501E.3030300@grandegger.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4899A4F7.70201@grandegger.com>
In-Reply-To: <4899A4F7.70201@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
> Hi Wolfgang,
> 
> On Wed, 06 Aug 2008 15:19:51 +0200, Wolfgang Grandegger wrote:
>> I realized that various HWMON drivers have been converted to new style.
>> Has the w83781d been ported as well? Or is somebody already working on it?
> 
> This is one of the two hwmon drivers that have not yet been converted
> (the other one is lm78.) I had been delaying them because they are
> special (hybrid drivers, supporting both I2C and ISA devices) and also
> because there are pending patches for these drivers and I was hoping
> that the pending patches could be merged first (but it didn't happen
> yet.) If you want to work on either of these drivers, please do. I can
> do some testing on both. If you have a particular interest in these
> drivers, maybe we can work together.

We need support for the MON35W42 on an embedded MPC8544 board, which 
seems to be compatible with the w83782d. There are more issues, e.g. the 
early ISA bus probing of the existing driver hangs the system. Maybe i2c 
probing should be done first!?

Wolfgang.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
