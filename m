From: michaelnel@comcast.net (Michael Nelson)
Date: Thu, 07 Sep 2006 13:23:09 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060907132309.GA7098@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 06, 2006 at 11:20:00PM -0700, David Hubbard wrote:

> I have attached an updated patch (it now includes changes to
> drivers/hwmon/w83627ehf.c and a new Documentation/hwmon/w83627ehf
> file), plus w83627ehf.c. Michael and Michael, please try out the new
> driver. 

Thank you!  It seems to work, somewhat:

seahunt:~ # sensors
w83627ehf-isa-0290
Adapter: ISA adapter
Case Fan:    0 RPM  (min = 1318 RPM, div = 128)
CPU Fan:   865 RPM  (min = 1704 RPM, div = 8)
fan3:     1997 RPM  (min = 21093 RPM, div = 4)
fan4:        0 RPM  (min = 10546 RPM, div = 128)
fan5:        0 RPM  (min = 168750 RPM, div = 8)
Sys Temp:    +28??C  (high =   +45??C, hyst =   +40??C)
CPU Temp:  +49.5??C  (high = +45.0??C, hyst = +40.0??C)
temp3:     +58.5??C  (high = +68.0??C, hyst = +66.0??C)

It doesn't show any voltages though.  But the voltages do show up in gkrellm.

I'm not sure what that temp3 is in the sensors output.  I think the one
labeled fan3 is actually the CPU Fan, at least from looking at the BIOS
values.  I probably need to tweak /etc/sensors.conf some.

>No changes to w83627ehf_regression.sh

It blows up for me:

seahunt:~ # sh /home/michaeln/w83627ehf_regression.sh
* WARNING: This will run your system fans through many possible
           combinations. There is a possibility your system will
           overheat. Use this script at your own risk!
cat: in9_input: No such file or directory


Thanks so much for the work you folks have done on this so far!

Michael

-- 

San Francisco, CA

