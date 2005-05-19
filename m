From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <3EFDDE71.6060504@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

With your fix and perl 5.005.02, at the beginning I get:

Useless use of a constant in void context at prog/detect/sensors-detect line 1345.

which doesn't s top the script, but later on (just after saying YES to ISA bus scan)

Your vendor has not defined Fcntl macro O_BINARY, used at prog/detect/sensors-detect line 1343.

and the script stops. So how do we get this to work on older perls?


Jean Delvare wrote:
>>>Could be... But there is one last thing I would like to try. My
>>>changes(-k3) don't seem to have had any effect, so I'm trying
>>>something similar but different. Please get
>>>  http://www.ensicaen.ismra.fr/~delvare/sensors-detect-k4
>>>and tell me, again, it it behaves differently with and without an
>>>UTF-8 locale.
>>
>>That seemed to fix it!!!
> 
> 
> "Ah ah ah (evil laugh) you nasty little bug, you thought you could lurk
> forever? Diiiiiiiie!"
> 
> Ahhhh I feel better :) For the ones interested, the solution was to call
> binmode(IOPORTS, ':raw') after opening '/dev/ports'. The ':raw' keyword,
> among other things, prevents Perl from using the UTF-8 layer on file I/O
> (where available). I did not find this first because I don't have Perl
> 5.8.0 on my development machine, and this layers thing is new in 5.8.0.
> I was told on IRC to have a look at the binmode perldoc page on Perl
> 5.8.0, which I did, and it led me to the solution.
> 
> Ok Jim, thanks a lot for your help again. I'll commit a clean fix to
> sensors-detect to CVS today.
> 
