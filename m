From: michaelnel@comcast.net (Michael Nelson)
Date: Wed, 06 Sep 2006 15:28:59 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060906152859.GA6180@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 06, 2006 at 08:07:24AM -0700, Michael Nelson wrote:
> On Wed, Sep 06, 2006 at 07:26:50AM -0700, Michael Nelson wrote:
> 
> I got the 2.6.18-rc6 kernel to build and boot.  Now to see if I can get that
> patch to apply.

I dropped the w83627ehf.c file into the
/usr/src/linux-2.6.18-rc6/drivers/hwmon directory and rebuilt kernel and
modules. It built fine, but after reboot it fails to load:

# sh /home/michaeln/w83627ehf_regression.sh
* WARNING: This will run your system fans through many possible
           combinations. There is a possibility your system will
           overheat. Use this script at your own risk!
No w83627ehf driver in system. Loading module.
FATAL: Error inserting w83627ehf
(/lib/modules/2.6.18-rc6-smp/kernel/drivers/hwmon/w83627ehf.ko): No such
device

Michael

-- 

San Francisco, CA

