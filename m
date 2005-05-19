From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Linux on GA-8LD533(-P)
Message-Id: <20030805210512.33341cf7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <03080518254600.09450@diva.localdomain>
In-Reply-To: <03080518254600.09450@diva.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> On the lm_sensors web site http://www2.lm-sensors.nu/~lm78/index.html
> support for the particular SMBus controller (implemented in the
> 82801DB chip) is mentioned but the sensor chip itself (implemented in
> the IT8702F) is not mentioned - only the IT8705 and IT8712.  And the
> IT8707 and IT8708 are mentioned as being definitely NOT supported at
> present.  So is the 8702 in this m/b like the 8705/8712 (i.e.,
> supported) or like the 8707/8708(unsupported)?

As seen on ITE's website, the IT8712F is pin compatible with the
IT8702F, so I'd expect both chips to be rather similar, and support
could be easy to add. You could even try forcing the it87 driver and see
if it gives interesting results.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
