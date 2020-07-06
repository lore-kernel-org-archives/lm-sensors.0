From: Richard Kimber <richardkimber@btinternet.com>
Date: Mon, 06 Jul 2020 12:42:01 +0000
Subject: Displaying fan speeds
Message-Id: <20200706134201.60f325f9@infinity>
List-Id: <lm-sensors.vger.kernel.org>
References: <20200704173041.4c81d305@infinity>
In-Reply-To: <20200704173041.4c81d305@infinity>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm running Ubuntu 20.04 on an Asus Prime Z370-A which has an Intel
Core i7-8700 CPU; this has 6 cores and 12 threads. 

With the 20.04 Ubuntu installation + lm-sensors, Gkrellm will display
the activity of the 12 threads, but not the fan speeds. (When I ran
sensors-detect it added
coretemp
nct6775
to /etc/modules)

I understand that if lm-sensors can see it, Gkrellm will display it.
When I run "sensors", it does not display fan speeds.

However, if I set the boot option acpi=off, sensors and Gkrellm will
display the fan speeds, but I can only see the 6 cores.

Is there a way of configuring things so that I can display both the
activity of the12 threads and the fan speeds?

- Richard
-- 
Richard Kimber
