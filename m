From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC
Message-Id: <20050509213403.2f0ea0a5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yani,

> With respect to the lm_sensors chip drivers an int alone might make
> sense (although for bmcsensors the void* is better), but when you
> start looking at the rest of the kernel code that uses attributes the
> void * looks like a very good decision.
> 
> If you have a look at my patch for net-sysfs.c for example, its hard
> (impossible?) to imagine a way to do a similar thing with just an int
> being passed to the callbacks, and this is using static attributes.

You could always define a static array of pointers, and use the passed
int as an index to that array, thus converting the int into a pointer.
It's not very different from defining a static array of ints and passing
the int addresses as the void*, but for some reason I tend to prefer the
int -> pointer conversion (most certainly because my view if awfully
biased by my misknowledge of the kernel except for the i2c and hardware
monitoring code).

> Yes, it is starting to look like the cold hand of a dictator might be
> needed ... where is Greg anyway ;-)?

Don't blame him, I am wasting his time over IRC, this is why... ;)

-- 
Jean Delvare
