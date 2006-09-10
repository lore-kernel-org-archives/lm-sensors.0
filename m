From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 10 Sep 2006 17:52:59 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060910195259.c4bf759e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

> Thank you!  It seems to work, somewhat:
> 
> seahunt:~ # sensors
> w83627ehf-isa-0290
> Adapter: ISA adapter
> Case Fan:    0 RPM  (min = 1318 RPM, div = 128)
> CPU Fan:   865 RPM  (min = 1704 RPM, div = 8)
> fan3:     1997 RPM  (min = 21093 RPM, div = 4)
> fan4:        0 RPM  (min = 10546 RPM, div = 128)
> fan5:        0 RPM  (min = 168750 RPM, div = 8)
> Sys Temp:    +28?C  (high =   +45?C, hyst =   +40?C)
> CPU Temp:  +49.5?C  (high = +45.0?C, hyst = +40.0?C)
> temp3:     +58.5?C  (high = +68.0?C, hyst = +66.0?C)
> 
> It doesn't show any voltages though.  But the voltages do show up in gkrellm.

You need lm_sensors SVN for voltage values:
http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-r4155-20060908.tar.bz2

> >No changes to w83627ehf_regression.sh
> 
> It blows up for me:
> 
> seahunt:~ # sh /home/michaeln/w83627ehf_regression.sh
> * WARNING: This will run your system fans through many possible
>            combinations. There is a possibility your system will
>            overheat. Use this script at your own risk!
> cat: in9_input: No such file or directory

Expected, as the W83627DHG doesn't have this voltage input. You'd need
to edit the script to skip in9 completely.

> Thanks so much for the work you folks have done on this so far!

Thanks for testing :)

-- 
Jean Delvare

