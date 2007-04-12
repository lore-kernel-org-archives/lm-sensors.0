From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Apr 2007 09:12:13 +0000
Subject: Re: [lm-sensors] Checking out and comitting to the libsensors-3.x
Message-Id: <20070412111213.6845c74a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4610BC25.8050507@hhs.nl>
In-Reply-To: <4610BC25.8050507@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 10 Apr 2007 16:43:54 +0200, Axel Thimm wrote:
> On Tue, Apr 10, 2007 at 04:23:10PM +0200, Jean Delvare wrote:
> > Ugh. But we didn't have the problem before. Any idea what changed, that
> > could explain why we suddenly have the problem? Maybe the switch to
> > mod_python? I think we have to switch back to the previous state until
> > the Trac folks provide a fix.
> 
> I tried one of the fixes mentioned ("PythonInterpreter
> main_interpreter"), I can't provoke the bug anymore (tried reload on
> the Devices page which previously was giving the error for me). Is
> that true on your side, too?

It looks OK so far, yes, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
