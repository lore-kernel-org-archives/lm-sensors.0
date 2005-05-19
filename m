From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: fan speed for it87?? chips added
Message-Id: <3F70E823.8090804@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309232035.29480.michael.hufer@freenet.de>
In-Reply-To: <200309232035.29480.michael.hufer@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I would recommend that you rename your 'reset_it87' option to 'init' to 
be consistent with the other drives.

Other drivers use 'init=0' to disable initialization of the chip limits.

:v)

Michael Hufer wrote:
> Hi,
> I recently bought a new computer system based on Shuttles XPC FN42G2 barebone 
> its motherboard uses the it8705 chip. Unfortunatly, I had to find out that 
> the current it87 driver resets the chip on init which switches the CPU/case 
> fan to a very noisy full speed. So, after some grumpling :-) I decided to 
> take things in my own hands and add some new features to the driver.
> 
> First, I added a new mod parameter "reset_it87" which controls whether or not 
> the chip is reset on module load (modprobe it87 reset_it=1, default) or 
> not(modprobe it87 reset_it87=0).
> Since this worked out quiet nicely I decided to go one step further and also 
> add the chips manual and automatic temperature controlled fan speed features 
> (PWM etc.).
> 
> Finally I also updated the doc to document the new features.
> 
> Attached is a diff against the current cvs version.
> 
> So long,
> 	Micha.


-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
