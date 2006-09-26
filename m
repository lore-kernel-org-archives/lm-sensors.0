From: michaelnel@comcast.net (Michael Nelson)
Date: Tue, 26 Sep 2006 22:56:50 +0000
Subject: [lm-sensors] coretemp - digital temperature driver for Intel
Message-Id: <20060926225650.GA15013@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4519A5C1.8010207@assembler.cz>
In-Reply-To: <4519A5C1.8010207@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 27, 2006 at 12:12:17AM +0200, Rudolf Marek wrote:
> Hello all,
> 
> I had today some time and coded the driver for Core 2 processors which will 
> read the temperature from the CPU. (precisely I worked on it from 16:36 to 
> 23:59 with some preemptions ;)
> 
> I dont have such CPU so I'm looking for brave testers!
> 
> The code is "virgin" it compiles but that is all I know. Testers should 
> expect oops, panic or simple crash... Or maybe if I did not make any 
> mistake (hehe) the temperature in 
> /sys/class/hwmon/correcthwmondir/temp1_input
> 
> To compile:
> make -C /lib/modules/`uname -r`/build SUBDIRS=$PWD  modules
> 
> Again this should be for either brave testers or persons with the knowledge 
> of C ... I will review the code tomorrow again.

Doesn't seem to work here with a Core2 Duo 6400 and kernel 2.6.18:

  cat /sys/class/hwmon/hwmon1/device/temp1_input
0

Thanks for the effort though!

Michael

-- 

San Francisco, CA

