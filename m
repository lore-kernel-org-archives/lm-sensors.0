From: clepple@ghz.cc (Charles Lepple)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: porting libsensors to the 2.6 kernel's /sys interface
Message-Id: <E6EF7896-C62E-11D7-BB43-003065DC6B50@ghz.cc>
List-Id: <lm-sensors.vger.kernel.org>
References: <CBF7F1A2-C175-11D7-BB43-003065DC6B50@ghz.cc>
In-Reply-To: <CBF7F1A2-C175-11D7-BB43-003065DC6B50@ghz.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sunday, August 3, 2003, at 08:23  PM, Mark D. Studebaker wrote:

> I think you are the first who has actually said he is working on it.

don't get your hopes up yet :-)

> First choice would be a single libsensors that works with both kernels.

I think this is feasible...

The thing is that I was expecting a simple mapping of old names to the 
new ones (i.e. splitting the 3-value /proc files into the separate /sys 
files). Greg was proposing a change in the libsensors API, however, 
which I'm pretty sure I wouldn't have time to do. (Or am I mistaken?)

Greg, what sort of API changes are you thinking of?

Am I not grasping the full depth of the change to the /sys interface? I 
have not really messed with the /proc nodes directly (as sensord took 
care of stuffing values into an RRD file for me), but it wasn't 
terribly hard to suck the /sys values into a Perl script.

> Greg is correct that we shouldn't be including kernel headers for the 
> userspace stuff.

I think Jean Delvare's patch will fix this up nicely. I just got back 
into town this evening, so I haven't had a chance to make sure that it 
works, though.

-- 
Charles Lepple <clepple@ghz.cc>
http://www.ghz.cc/charles/
