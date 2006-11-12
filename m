From: azummo-lists@towertech.it (Alessandro Zummo)
Date: Sun, 12 Nov 2006 15:32:26 +0000
Subject: [lm-sensors] DS2321 guidance
Message-Id: <20061112163226.38b7f491@inspiron>
List-Id: <lm-sensors.vger.kernel.org>
References: <200611071505.kA7F5WaS011759@godiva.ta-18.lanl.gov>
In-Reply-To: <200611071505.kA7F5WaS011759@godiva.ta-18.lanl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 07 Nov 2006 07:53:13 -0700
Benjamin Sapp <bsapp at lanl.gov> wrote:

> Hello,
> 
> I would like to get the DS2321 Real time clock to work with 
> lm-sensors.  The DS2321 is very similar to the DS1307.  In fact the first 
> six bytes are identical.  Where the DS1307 has NVRAM, the DS2321 has no ram 
> and instead has a temperature sensor.   My current setup is an i.MX21 ARM 

 [...]

 Hi Benjamin,

  most of the development is now geared toward the 2.6 kernel. rtc
 drivers now have their own subsystem too. If you think
 you are willing to move to 2.6 I can be of some help.

  ARM is quite well supported under 2.6 and you
 would benefit of the rtc and hwmon subsystems, among
 many other features.

  I've done a lot of work with ARM board support packages on 
 5/6 arm system in the last months, together with the
 fine people of the nslu2-linux project.. so, if you need
 help, just drop a note.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it


