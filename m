From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: Compiling lm_sensors module with gcc 3.3. (A problem and
Message-Id: <3EF5C277.5040706@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EF4DD25.6000802@yk.rim.or.jp>
In-Reply-To: <3EF4DD25.6000802@yk.rim.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

would you please send us the entire output of 'make' so we can clean up the warnings. Thanks.

Ishikawa wrote:
> "Mark D. Studebaker" wrote:
> 
>>thanks for the report.
>>We've already attempted to fix things in CVS.
>>Would you please try it for us using gcc 3.3.
>>There's a link on our home page (May 31st entry)
>>to the new makefile and the file etc/config.c, which is also needed.
>>
> 
> 
> Thank you for your quick response.
> 
> I downloaded the Makefile and etc/config.c
> and retried compiling lm_sensors 2.7.0 using gcc 3.3.
> 
> Well, the compilation produced lots of warnings
> about system headers (now used CC options include -Wall), but
> the compilation succeeded!
> 
> I looked at the difference in Makefile.
> Obviously the use of -nostdinc on the gcc command line,
> and specifying the necessary header directories in correct/desired 
> order explicitly using -I helped.
> (Actually I played with -nostdinc when I encountered the problem, 
> but I didn't know the "-print-search-dirs" directive to GCC. So
> I could not figure out where GCC would be searching for the
> standard headers in GCC's default scheme. There I gave up, 
> and decided to use the different directory for i2c headers in
> my suggested patch.)
> 
> Thank you again for your great piece of software!
> 
> Happy Hacking
> 
> PS: maybe your entry dated May 31st might want to mention
> gcc 3.3 (or gcc 3.x) since I obviously missed 
> this entry when I checked your web page yesterday...
> 
> Ishikawa, Chiaki
> 
