From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 31 Mar 2007 12:36:00 +0000
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <20070331143600.9bdaef1e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <46084A44.4070101@eberian.com>
In-Reply-To: <46084A44.4070101@eberian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Wed, 28 Mar 2007 13:20:33 +0200, Hans de Goede wrote:
> Ivo Manca wrote:
> > Hey Ed,
> > 
> >> I looked at sqlite when developing sensors4mobo but many ISPs do not 
> >> include it and I did not want to add any dependencies that would limit 
> >> usage or make installation harder.
> 
> <lots of explanation by Ivo about sqlite plans snipped>
> 
> Actually I have been thinking about using the annotating of sensors.conf file 
> myself in the past, but I thought sqlite would be easier to use, esp. on the 
> web-side. Since with sensors4mobo we kinda get the web-side for free, and I 
> also _really_ like the idea of the database being a dir of textfiles with one 
> file per motherboard allowing for easy tinkering / experimenting by end users, 
> I think it might be a good idea to go with the dir with one textfile per mobo.
> 
> But less discuss this further tomorrow at our (face to face) meeting. Jean, any 
> thoughts / preferences on this?

For the local data, I'd go for text files. Each motherboard being
uniquely identified by a finite number of DMI strings, we can
combine them to form a unique identifier and use that in the
configuration file name. Ideally this should be something like
sensors-$manufacturer-$model-$version.conf, but we'll see how it goes
in practice. With this naming convention, lookups are in O(1), which is
perfect.

Now, it might still be good to have a database as the backend of the
website, that's a different story. It should be easy enough to generate
all the text files from the database, adding metadata as comments at
the beginning of the files.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
