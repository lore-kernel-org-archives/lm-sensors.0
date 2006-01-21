From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 21 Jan 2006 09:47:21 +0000
Subject: [lm-sensors] move to new website - status?
Message-Id: <43D20329.6030007@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43D15E0D.1020309@sh.cvut.cz>
In-Reply-To: <43D15E0D.1020309@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,


> The flipping picture issue in trac seems to be a known issue, but
> there is still no upstream fix for it. I'd place that further back in
> the queue to give upstream a chance to fix it. OR to allow
> experimenting with switching from cgi to mod_python serving, which
> might fix the issue (since the bug seems to be in trac's cgi methods).

OK

> The switch to svn can be done as soon as everyone with current CVS
> write access is comfortable with the test svn repo. The repo can be
> remigrated from current CVS within short time, so as soon as there is
> agreement, give us the go, and we'll set it up for good.

OK
> That's the first item I'd like to see done.
OK I will send you my pub key and will start to learn how to live with svn :)

Well we need to convert the newdrivers/supported thats the last thing left (from web perspecitive)

Quoting Jean some time ago:
> Quoting Michael Renzmann a few days ago:
> 
> << Some of the remaining pages, most notably the "supported devices" and
> "new drivers" ones, use tables with cells that span more than one row
> and/or column. This type of table can be better rendered when support
> for "restructured text" is enabled, see:
> http://lm-sensors.org/trac/wiki/WikiRestructuredText - any chance we get
> this on the lm_sensors Trac installation? >>
> 
Please can you do that?

Phil, what about the ticket system conversion as Jean mentioned it?

Thanks
Regards
Rudolf

