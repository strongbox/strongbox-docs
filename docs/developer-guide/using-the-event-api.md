# Using the event api

## Introduction

The code for the events API is located under the [strongbox-event-api] module.

## Events

All events must extend the [org.carlspring.strongbox.event.Event] base class.

## Event Listeners

All event listeners must implement the [org.carlspring.strongbox.event.EventListener] base class.

The [org.carlspring.strongbox.event.EventListener] has this following simple method which every listener need to 
implement and where the respective event handling will be performed:

```java
public interface EventListener
{
    void handle(Event event);
}
```

## Event Listener Registries

Event listener instances must be registered with the respective implementation's listener registry, which will be used 
to dispatch events to them.  
  
All event listeners must extend the [org.carlspring.strongbox.event.AbstractEventListenerRegistry] base class.  
  
Consider the following example, of how to register you listener:  

```java
public class ArtifactEventHandlingExample
{

    @Inject
    ArtifactEventListenerRegistry artifactEventListenerRegistry;
    
    public void doStuff()
    {
        // Create the listener
        DummyArtifactEventListener listener = new DummyArtifactEventListener();
        
        // Add the listener to the registry
        artifactEventListenerRegistry.addListener(listener);

        // Create an event
        ArtifactEvent artifactEvent = new ArtifactEvent(ArtifactEvent.EVENT_ARTIFACT_UPLOADED);

        // Tell the registry to dispatch the event to all registered listeners:
        artifactEventListenerRegistry.dispatchEvent(artifactEvent);
    }

    private class DummyArtifactEventListener implements ArtifactEventListener
    {

        @Override
        public void handle(ArtifactEvent event)
        {
            System.out.println("Caught artifact event type " + event.getType() + ".");
        }

    }

}

```


[strongbox-event-api]: https://github.com/strongbox/strongbox/blob/master/strongbox-event-api/
[org.carlspring.strongbox.event.Event]: https://github.com/strongbox/strongbox/blob/master/strongbox-event-api/src/main/java/org/carlspring/strongbox/event/Event.java
[org.carlspring.strongbox.event.EventListener]: https://github.com/strongbox/strongbox/blob/master/strongbox-event-api/src/main/java/org/carlspring/strongbox/event/EventListener.java
[org.carlspring.strongbox.event.AbstractEventListenerRegistry]: https://github.com/strongbox/strongbox/blob/master/strongbox-event-api/src/main/java/org/carlspring/strongbox/event/AbstractEventListenerRegistry.java
