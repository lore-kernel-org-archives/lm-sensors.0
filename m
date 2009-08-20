From: "HUSSON Pierre-Hugues" <phhusson@free.fr>
Date: Thu, 20 Aug 2009 23:47:37 +0000
Subject: Re: [lm-sensors] fancontrol using 100 megs?
Message-Id: <200908210147.37772.phhusson@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <9871ee5f0908201427g2c23367awa83ab27ddce9337f@mail.gmail.com>
In-Reply-To: <9871ee5f0908201427g2c23367awa83ab27ddce9337f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Le jeudi 20 ao=FBt 2009 23:27:35, Timothy Normand Miller a =E9crit :
> I've had my Linux box up for weeks.  I was looking at top and noticed
> that the VIRT column for fancontrol said "100m".  Now, I know you're
> supposed to take VIRT with a grain of salt because it includes all
> kinds of things like shared memory, etc.  But isn't 100 megs a bit
> excessive?  Isn't this just a shell script?
>
> BTW, RES and SHR are 2944 and 504, respectively.
The VIRT column doesn't mean anything on linux (and any other modern OS),=20
well, it's the allocated memory size. The actual memory consumption includi=
ng=20
libraries is RES+SHR, so 3.5MB, which seems fine to me for that.
But if you prefer, you can rewrite it in plain C, with all the debuggings a=
nd=20
so on to gain maybe 2MiB :)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
