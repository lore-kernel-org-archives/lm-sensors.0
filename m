From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 29 May 2006 10:09:12 +0000
Subject: [lm-sensors] LM Sensors autoconfig tool project awarded as
Message-Id: <20060529120912.895607eb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44744596.40406@hhs.nl>
In-Reply-To: <44744596.40406@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> Besides writing the abituguru driver I'm also active (actually mainly 
> active) as a Fedora contributer. A few weeks ago the Fedora board asked 
> for ideas/projects for Fedora's participation in Google's Summer of Code 
> (SOC: http://code.google.com/soc/). Ever since working on the abituguru 
> driver I've had this dream / project in my head for better & easier 
> autoconfiguration of lm_sensors for a specific setup.
> 
> Thus I took this chance to propose an lm_sensors autoconfig tool as a 
> Fedora SOC project. As already said sorry for not involving you all 
> earlier, I didn't expect much to come of this.
> 
> It has turned out however that much has come of this. 4 "students" have 
>   submitted official applications to google to undertake this project! 
> And 2 more have send me emails but didn't file their applications with 
> google. And I have applicated to be the Mentor for one of these students 
> who seems like an excellent candidate.
> 
> Its very likely (not 100% official yet) that this project will be 
> approved and that the student I've applicated to Mentor will be working 
> on this this summer.
> 
> Even though this is a Fedora project, I believe that the lm_sensors 
> team/community getting involved is important if not vital and that the 
> project should be implemented in an as distro neutral way as possible, 
> hence my mail to you.
> 
> For the project as described by me when suggesting it see:
> http://fedoraproject.org/wiki/FedoraBounties#head-5a66fb1f8ba2fa17d980e9d4df54c2b61e76ca54

Sounds like a very good idea. A few users tried to setup similar
projects before, but nobody ever came up with something functional
enough to be used. If the project is completed and ends up being
operational, this would be a great improvement for the lm_sensors
project, making the setup phase much easier in many cases.

Using dmidecode to get the motherboard identification sounds right.
Note that I have implemented a command line interface to dmidecode,
which should come in handy:

$ dmidecode -s baseboard-manufacturer
Supermicro
$ dmidecode -s baseboard-product-name
370DL3/370DLE
$

This requires dmidecode >= 2.7.

A few comments about DMI tables:
* Depending on the system, the DMI table may be conveniently and
accurately filled, or empty, or useless. Systems with poor DMI tables
won't be supportable.
* Some systems have no type 2 (Base Board Information) DMI record but
do have type 1 (System Information) or type 3 (Chassis Information)
records you can fall back on.
* The full output of dmidecode can contain data which shouldn't be made
public (serial numbers, UUIDs etc.) so you must make sure to only ask
the user for what you need.

I don't think that being able to export the database is a key feature.
End users shouldn't need this.

Likewise, I don't like the hotplug/udev stuff you mention in point 2.
Configuration is only done once, so I don't quite see how hotplug is
relevant here. It's more simple, and more efficient too, to integrate
the motherboard recognition code into sensors-detect. If enough DMI
data is available, propose to connect to the online database to find a
configuration file. If a configuration file is found, copy it, and skip
all the probing phase. This is how I'd do it, anyway.

-- 
Jean Delvare

