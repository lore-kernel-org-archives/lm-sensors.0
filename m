From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: Call for 2.8.2 soon
Message-Id: <3FC8E43A.301C9A75@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FC1646D.18B8555A@paradyne.com>
In-Reply-To: <3FC1646D.18B8555A@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

great. I too waited too long to begin playing with 2.6.
It was a pain to get everything going but now I'm in pretty good shape.

On via686a, sometimes it would register and sometimes it wouldn't.
Try rmmoding and modprobing a few times. I think if I rmmodded the
whole i2c stack including i2c-core and starting over it would show up.
Haven't gotten to the bottom of it yet. Maybe you can.

Thanks for fixing sensors segfault.

Jean Delvare wrote:
> 
> > How about if I tar up my /sys and send it to you for testing?
> > Then you could test on 2.4.
> 
> Thanks for the proposal, but that wouldn't have been a good idea. This
> would have left me in my laziness and I would never have installed 2.6.
> Now this is done :)
> 
> I have 2.6.0-test11 up and running on my other (non-laptop) computer.
> Couldn't get it on my laptop (which is also my main development system),
> it's getting too old and I would have had to update half a dozen system
> tools and libraries. The other system is much more recent and I could
> get 2.6.0-test11 to work on it, almost perfectly. I have sound working,
> my DC10+ board also works (although the visual quality is rather poor,
> don't know why). I also have a brand new LCD display on that machine,
> (which in turn could become my main development system again ;)) and
> have a 1280x1024 framebuffer console and X running with reasonable
> performance (you don't need too much for a text editor and a shell). And
> now I also have sensors working. Eeprom support is missing though, and
> for some reason the via686a driver failed to detect my hardware, while
> it used to do. I don't really care because the chip is actually not
> wired so it returns useless values, but this probably means there's
> something waiting for us to fix it in there.
> 
> The eeprom problem isn't really important, I think. We could even
> consider disabling detection in sensors-detect for a while, until the
> problem is fixed. Since eeprom contents are now returned in a binary
> form, I guess it'll be harder to get it to work through libsensors.
> Same problem for decode-*.pl scripts I guess.
> 
> Anyway, I will now be able to test and develop on a 2.6 system, so feel
> free to request my assistance whenever needed.
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
