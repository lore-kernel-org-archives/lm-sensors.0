From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: Fw: Re: Varyfan
Message-Id: <20030925201116.362dbeba.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030924225753.555af42b.khali@linux-fr.org>
In-Reply-To: <20030924225753.555af42b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Begin forwarded message:

Date: Thu, 25 Sep 2003 19:13:27 +1000
From: Ian Nicholls <iann@melbpc.org.au>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: Varyfan


On Thu, 25 Sep 2003 06:57, Jean Delvare wrote:
> How live is your project? Are you still working on it?

I'm no longer working on this project, and I was only developer.  (Want
to take it over?). I now have a quiet PC that doesn't require the
software to keep the noise down.  And anyway, I'm using kernel 2.6-test,
which isn't yet supported by the sensors package.  I was thinking that I
should put a note on the web page about it now being abandonware.

There were user-interface things on my wishlist (Qt, scrolling graph,
etc.), but basically, the only functional improvement would be in the
equation.

> How does it compare with our own PWM programs?

Pretty much the only advantage would be the fact that varyfan is written
in C, it would have a smaller footprint, and wouldn't need to execute
other programs every cycle.  The equation to propose a new fan speed is
different (mine is linear, yours looks like it might better fit the
speed vs airflow curve).

> We have a "useful links" page and could add a link to your page there
> if you think that your project is of general interest for our users.

When I started the project, I couldn't find a Linux version of the
Speedfan program.  Now you've got an actively maintained program and
I've got a more or less abandoned one, it might be best not to bother. 
Of course, if you still think it might be interesting to others, go for
it.

Thanks for the interest.




-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
