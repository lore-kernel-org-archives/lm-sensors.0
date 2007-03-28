From: Ed Lucas <ejl@eberian.com>
Date: Wed, 28 Mar 2007 09:30:49 +0000
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <460A35C9.60309@eberian.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46084A44.4070101@eberian.com>
In-Reply-To: <46084A44.4070101@eberian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Folks,
(Jean: Apologies for the Reply-to mix-up. I hope I have it fixed now?)

Ivo Manca wrote:
> Anyway, I agree that having more than one project is everything but 
> desireble. 
Hmm, playing devils advocate here, I don't know if the projects have 
quite the same goals. If not, it might be just as desirable to find 
areas of compatibility.

Ah, I have just found Ivo's thread started on the 22nd February, and 
read the Project Plan (hence the delay in replying - sorry!) . That 
makes things much clearer. The projects are very similar, but I *think* 
sensors4mobo is unique in aiming to add local data overlays?

> Since we started to add these functions to sensors-detect anyway, I 
> think it is best if we just continue with it and take the best 
> practices from the other projects. I think it is also the best if this 
> functionality is added to the sensors-detect script, instead of 
> (multiple?) other scripts.
I think you are right that it makes sense to add the functionality to 
sensors-detect, and working directly under Hans, you are certainly 
ideally placed to do this.

I see from your plan that your Secondary Goal is to build a database of 
sensors.conf files (with a web interface), but that hosting and 
maintenance are outside your scope. If you don't already have this 
sorted through lm-sensors.org, I would be happy to offer ongoing hosting 
and maintenance, and can give you access rights on 
sensors4mobo.eberian.com.

Would you be interested in using the sensors4mobo sensors.conf 
annotation (or a derivative) to add dmidecode and modprobe data to the 
files? And/or would you be interested in using the web api (or a 
derivative) as an interface to the library?

http://sensors4mobo.eberian.com/docs/sensors_conf

    I think it is best to embed information in the sensors.conf rather 
than to use a database. It is backward compatible, and makes each 
configuration a tidy unit - much easier to copy/duplicate/update than a 
database. I know it is slower and more limited than a db in terms of 
querying, but I have just run a test and sensors4mobo.php parsed 1000 
files in under 0.8 seconds on a 1.3Ghz Sempron. We probably don't need 
to optimise just yet? I think it is also easier this way if users want 
to create their own mirror sites with customised/experimental 
sensors.conf files.


http://sensors4mobo.eberian.com/lookup/

    In addition to the query engine itself, this page also has notes on 
how the REST-ish interface works. It currently takes the 17 tags 
specified by dmidecode --strings, but of course it could be restricted 
to the subset your research has focused on.


Irrespective of technical factors, and beyond the scope of your project, 
the broader campaign will stand or fail on whether it can get a critical 
mass of sensor.conf files. The sooner we can start the ball rolling on 
this, the better, and the more data-points you will be able to test 
against. The sensors4mobo scripts (or derivatives!) could provide a way 
for current users to get involved before your code gets integrated and 
released.

I appreciate that you are doing this as a university project, and I 
don't want to undermine, impinge, or force an unwanted direction on your 
work, but I am keen to assist if there is a way to integrate into the 
bigger picture.

Best regards,
    Ed



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
