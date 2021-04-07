#include <chrono>

typedef std::chrono::high_resolution_clock hrclock;

class Timer {
    hrclock::time_point t1;
 public:
    void start() {
        t1 = hrclock::now();
    }
    void print_elapsed() {
        std::cout << std::chrono::duration_cast<std::chrono::milliseconds>( hrclock::now() - t1 ).count()
                  << " ms"
                  << '\n';
    }
};
