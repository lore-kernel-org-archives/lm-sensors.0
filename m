From: philpi@apu.edu (Phillip Pi)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: Quick Question: How do I turn off beep_enable alarm?
Message-Id: <Pine.LNX.4.44.0212021157380.24155-100000@home.apu.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0211300516220.12614-100000@home.apu.edu>
In-Reply-To: <Pine.LNX.4.44.0211300516220.12614-100000@home.apu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks. I will upgrade the old 7.1 box with 2.6.1 sensors when I need to. 
Why upgrade if it works? ;)
-- 
"I got this aunt... Carpenter ant." --Girl and Crow
  /\___/\
 / /\ /\ \        Phillip Pi (Ant); The Ant Farm: http://antfarm.ma.cx
| |o   o| |
   \ _ /                E-mail: philpi@apu.edu or philpi@earthlink.net
    ( )

On Mon, 2 Dec 2002, Jean Delvare wrote:

> 
> > Ah thanks. I thought there was a global setting. I checked my other
> > Linux box and its sensors.conf doesn't have ignore beep_alarm lines
> > anywhere. Yet, sensors v2.6.1 command shows: 
> > 
> > beep_enable:
> >           Sound alarm disabled
> 
> Sounds logical, adding an "ignore beep_alarm" line would prevent sensors
> from displaying it. BTW, I invite you to update senors to at least
> 2.6.3, 2.6.5 would be better.
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
> 
> 
