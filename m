From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 04 Aug 2005 15:34:28 +0000
Subject: [lm-sensors] Query on compilation of lm_sensors
Message-Id: <2ZknybgX.1123162043.7194340.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D8B16F753179D4588D4B0C8FF7EAC450217D036@bgsmsx402.gar.corp.intel.com>
In-Reply-To: <3D8B16F753179D4588D4B0C8FF7EAC450217D036@bgsmsx402.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Harshad,

> I am using lm_sensors to communicate to some devices on SMBus.
> I tried to compile the "lm_sensors-2.9.1" and "i2c-2.9.1". But in one
> of our board which has Redhat RHEL 3.0.
> The compilation is continuously going into infinite mode. I think it is
> recursively compiling the same stuff.
> I was not able to install the i2c 2.9.1 also.
> 
> Has anyone faced the problem of continuous compilation (infinitely the
> same thing) of i2c and lm-sensors.
> Please provide pointers if anyone knows it.

Check your system date. What you describe is typical of systems where the
system date is set way in the past.

--
Jean Delvare
