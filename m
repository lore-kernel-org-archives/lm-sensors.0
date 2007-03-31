From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 31 Mar 2007 12:50:41 +0000
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <20070331145041.12f4ec25.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <46084A44.4070101@eberian.com>
In-Reply-To: <46084A44.4070101@eberian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivo,

On Thu, 29 Mar 2007 15:20:53 +0200, Ivo Manca wrote:
> One thing I noticed, looking through your code, was the fact that your 
> script is capable of finding multipe matches. I wonder whether or not this 
> is something we want to have there?
> Giving a random, unique DMI string, there should only be one possible 
> configuration, unless the dmistrings are bogus.
> 
> It is possible that users want to improve the config, but then he or she 
> should just modify the existing and upload it, isn't it?
> So I don't really see a point of supporting more matches. Maybe I'm 
> overlooking something.

Different people might upload a configuration file for the same
motherboard, in the "unconfirmed" state or whatever we call it. Until
someone reviews them, validates one of them and discards the other, we
have two files for the same board. So yes, it can happen. There should
never be several "confirmed" configuration files for a given board,
though.

Now, what is true of the website database may not be true of the local
cache (files in a directory, if we do that.) We may decide to only
export the confirmed files for the cache, for example, or only one of
the possible configurations (maybe based on a mark given by the site
visitors.) I have no strong opinion on this.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
