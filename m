From: roger@planbit.co.uk (Roger Lucas)
Date: Tue, 06 Jun 2006 20:55:49 +0000
Subject: [lm-sensors] LM Sensors Autoconfig Tool
Message-Id: <20060606205555.DAB0C12ED4@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485D48C.7010507@Ivn.cl>
In-Reply-To: <4485D48C.7010507@Ivn.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivan,

I am really pleased that this project has been created.  It is the "missing
piece" for lm-sensors.

I have around 5 or 6 different motherboards here.  If you want the dmidecode
results from them I will happily send them to you.  If enough other people
did the same then you will probably find there are some dmidecode reports
for different motherboard revisions in the mix.  It is a bit random but it
is one route you could take.

The kernel ACPI team ask that the output of dmidecode is provided to them
when raising bug reports (although admittedly not everyone posts the data),
so they should have quite a lot of data from different motherboards too.

Have you tried asking motherboard manufacturers directly about this?  Some
manufacturers are quite helpful if you explain what you are doing and
exactly what information you need.

Good luck with the project.

- Roger

> -----Original Message-----
> From: lm-sensors-bounces at lm-sensors.org [mailto:lm-sensors-bounces at lm-
> sensors.org] On Behalf Of Ivan Barrera A.
> Sent: 06 June 2006 20:16
> To: lm-sensors at lm-sensors.org
> Subject: [lm-sensors] LM Sensors Autoconfig Tool
> 
> Hi !
> 
> I recently subscribed to the list, as i'll be the one developing an
> Autoconfig Tool for Lm Sensors.
> 
> I've been taking a look with Hans de Goede in which way is the best to
> identify a motheboard, and each sensor. (as well, as how to write a user
> tool which will look into the database and write the configuration).
> 
> The project consist en 2 main parts :
> 
> 1 - A web application which will mantain a database with the info about
> motheboard - sensors and configurations. (as well as some "use notes").
> 2 - User tools which will be able to query the database and get the
> correct configuration for the motheboard/sensors detected.
> 
> For this month's end i pretend to have a basic working website, as well
> as a basic user-tool.
> The next month, i'll want to work on the details (some gui, more
> advanced website, etc)
> 
> Now, i'm working on how to detect correctly different motheboards and
> sensors, to build the database. I own lots of motheboards, however most
> of them are too different (i want to see, how similar are the reports of
> dmidecode on "similar" motheboards (i.e. different revisions)).
> 
> I've been reading the earlier posts about his, to see more ideas on how
> to detect this configurations. So, if any has ideas on this, let me know.
> 
> I don't want to be a pain to the list, so, i'll keep informed on
> relevant issues working on the project. (as well, as some personal
> questions about some drivers :) )
> 
> Well, this is just an introduction post. I'll write more as soon as i
> have more news.
> 
> 
> Ivan Barrera A. [Bruce]
> 
> PS: Excuse my english. It's a little rusty , as i haven't practiced in
> some time.
> 
> 
> 
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


