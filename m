From: scott_anderson@mvista.com (Scott Anderson)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: New bus driver for Xilinx Virtex-II Pro (FPGA with a PowerPC 405)
Message-Id: <3D8FEDC1.B5FE25EE@mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D7FAE37.D4D6D006@mvista.com>
In-Reply-To: <3D7FAE37.D4D6D006@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

"Mark D. Studebaker" wrote:
> I suggest you familiarize yourself with our i2c stack and the interface
> to it,
> then you should be able to write a much smaller driver. There are plenty
> of examples
> in kernel/busses in our package.
> You may not even need separate algo and adap drivers.
> 
> good luck.
> mds

Thanks for the information.  Once I finish up what I'm working on right
now, I'll go back and revisit that driver and then resubmit the request.

Thanks again,
    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               1237 East Arques Ave.
    http://www.mvista.com       Sunnyvale, CA  94085
