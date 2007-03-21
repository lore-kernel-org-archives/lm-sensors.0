From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 21 Mar 2007 17:09:44 +0000
Subject: [lm-sensors] SUCCESS! Re: MSI K9N4 SLI-F sensors-detect says
Message-Id: <20070321180944.63cd0a38.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4600D064.1020703@curtronics.com>
In-Reply-To: <4600D064.1020703@curtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Curt,

On Wed, 21 Mar 2007 01:27:48 -0500, Curt Blank wrote:
> Ok, I answered my own question, yes I can backport the w83627ehf driver 
> from 2.6.21 to 2.6.16.
> 
> If anyone is interested I put the patches here:
> 
> http://www.curtronics.com/patches/
> 
> Not bad for one nights work.
> 
> Below is the living proof. The chip ID reported by the W83627DHG on this 
> MB was different then what the 2.6.21 w83627ehf code looked for so now 
> it looks for both. There are 4 fans connected to this MB but only 3 are 
> showing up, the 4th is a MSI installed fan on the Northbridge chip. 
> Maybe I can't see that one, I don't know at this point. I have to 
> validate the voltages also, they don't look quite right.

Two comments about this patch:

1* You didn't have to convert the semaphores to mutexes. This is a
kernel-wide change that happened at one point in time, and is not
related with the W83627DHG support at all. Without that change, your
patch will be smaller.

2* You do not need to change the device ID. If you look at the code,
you'll see that we do explicitely mask out the lower bits, because they
are _known_ to change depending on the exact chip revision. So the
original code should work just fine for you too.

-- 
Jean Delvare

