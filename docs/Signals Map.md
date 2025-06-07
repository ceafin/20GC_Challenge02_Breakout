# 📡 Signals Map
All of the signals should be in the Global Signals Bus (GSB) unless wholly internal to a particular packed scene.

| Emitter     | Signal          | Listener    | Method Called           | Notes                    |
| ----------- | --------------- | ----------- | ----------------------- | ------------------------ |
| Ball        | `lost`          | GameManager | `_on_ball_lost()`       | Ball fell off screen     |
| Brick       | `destroyed`     | GameManager | `_on_brick_destroyed()` | Adds score, updates UI   |
| GameManager | `lives_updated` | HUD         | `_on_lives_updated()`   | HUD updates life counter |
