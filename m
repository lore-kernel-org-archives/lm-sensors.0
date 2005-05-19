From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: Please list which file to etc/rc* file modiify
Message-Id: <20041121202913.5062291f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1100659621.2956.12.camel@Oneniisama>
In-Reply-To: <1100659621.2956.12.camel@Oneniisama>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi Jean,
> 
> Hmmm. I'm going to butt in with a suggesstion. Using strace seems to
> me to be inherently user unfriendly (but it will of course give up the
> required tidbit of information).

True, this is user unfriendly and highly valueable for us developers.
strace will tell so much more than just where the configuration file is
read.

Nevertheless...

> Would it make sense for sensors to print out the name of the
> configuration file as one of the first lines of output?

Not as part of the output, where I would consider it noise. However,
printing the information as part of "sensors --help" would be great,
agreed. I just added that (together with removing the default
configuration file locations list, and having only one default
configuration file, which sounds sufficent and saner).

> Disclaimer: I myself am new to the lm_sensors scene and I've never
> actually run sensors on any computer yet.

Feel free to voice in and, why not, provide some code if you have other
good ideas like this one :)

Thanks,

-- 
Jean Delvare
http://khali.linux-fr.org/
