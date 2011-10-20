From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 20 Oct 2011 06:12:03 +0000
Subject: Re: [lm-sensors] Query regarding temperature readings
Message-Id: <20111020081203.53ec879d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAELdg1D0dCEg0e7wv6u=BmxCCy=4=uvyv3fG7PgzUSFoZAj5GQ@mail.gmail.com>
In-Reply-To: <CAELdg1D0dCEg0e7wv6u=BmxCCy=4=uvyv3fG7PgzUSFoZAj5GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 20 Oct 2011 11:20:37 +0530, Bijju Kranthi Veduruparthi wrote:
> My problem with lm_sensors while reading temperature is as follows:
> 
> When I execute sensors command directly at the terminal, the temperature is
> output to the terminal correctly.
> 
> But when I execute sensors from a c program using the system() function, the
> temperature output to the terminal is more than the actual temperature.
> Through a C program the output temperature is always atleast *8 to 10 degree
> centigrade higher*.
> 
> Why does this problem arise?

No idea, but odds are that you are doing something incorrectly.

>I am reading the temperature in an incorrect way through C program?

How can we tell when you did not show your code to us?

> Is there a better way to obtain temperature through C code?

Depends on what you want to do exactly, you didn't tell.

Still, I suspect that you'd rather link directly with libsensors and
only do the few library calls you need (namely sensors_init,
sensors_get_detected_chips, sensors_get_features and sensors_cleanup.)
You can look at the code of the sensors command line program for an
example. The API is also documented in a man page (libsensors(3).)

Linking directly with the library is much more efficient than calling
sensors through system(), especially if you are only interested in a
few specific values.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
