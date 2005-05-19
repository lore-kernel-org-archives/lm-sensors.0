From: timm@fnal.gov (Steven Timm)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: Ticket 1833
Message-Id: <Pine.LNX.4.58.0412061148550.25485@boxer.fnal.gov>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0412020915370.25485@boxer.fnal.gov>
In-Reply-To: <Pine.LNX.4.58.0412020915370.25485@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

According to winbond web site there are a couple of new chips 
they recently released:

http://www.winbond.com.tw/E-WINBONDHTM/team/news.asp#03

Either W83627EHF or W83792D.  
Any chance the chip is one of them?

Steve Timm


------------------------------------------------------------------
Steven C. Timm, Ph.D  (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Div/Core Support Services Dept./Scientific Computing Section
Assistant Group Leader, Farms and Clustered Systems Group
Lead of Computing Farms Team

On Fri, 3 Dec 2004, Mark M. Hoffman wrote:

> Hi Steven:
> 
> * Steven Timm <timm@fnal.gov> [2004-12-03 12:36:34 -0600]:
> > Further followup ticket 1833
> > 
> > i2cdump showed the chip at 0x2f on the i2c bus to be a winbond type chip.
> > I was able to follow the instructions on the web page and do 
> > 
> > insmod w83781d force_w83781d=0,0x2f
> > 
> > We then saw the following:
> > (...)
> 
> OK cool.  That's about as much as you can do, because the i2c dump also
> shows a chip id of 0x7a, which is (unless I'm mistaken) nothing we've
> seen before.  See if you can physically locate a second Winbond chip on
> your board somewhere.  It's likely to be much smaller than the SuperIO
> chip (w83627hf as mentioned below) - perhaps the size of your smallest
> fingernail.
> 
> > (...)
> > Once this insmod is done, a second chip is detected at 2c as well,
> > which was previously not detectable
> 
> Now that is weird.
> 
> > (...)
> 
> Not much left to do, except tweak sensors.conf as necessary for your 
> setup.  Follow up here if there's anything else.
> 
> Regards,
> 
> -- 
> Mark M. Hoffman
> mhoffman@lightlink.com
> 
> 
