"""
Onboarding Page for Multitudes - First Time Setup

Beautiful 5-phase survey wizard for persona discovery.
"""

import streamlit as st
import requests
from typing import Dict, Any, List

# API configuration
API_BASE_URL = "http://localhost:2701"


def check_authentication():
    """Ensure user is authenticated"""
    if "access_token" not in st.session_state:
        st.error("Please log in from the Home page first")
        st.stop()
    return st.session_state.access_token


def check_onboarding_status(token: str) -> Dict[str, Any]:
    """Check if user has completed onboarding"""
    try:
        response = requests.get(
            f"{API_BASE_URL}/api/onboarding/status",
            headers={"Authorization": f"Bearer {token}"}
        )
        if response.status_code == 200:
            return response.json()
        return {"completed": False, "persona_count": 0}
    except Exception as e:
        st.error(f"Error checking status: {e}")
        return {"completed": False, "persona_count": 0}


def get_survey_config(token: str) -> Dict[str, Any]:
    """Get survey configuration from API"""
    try:
        response = requests.get(
            f"{API_BASE_URL}/api/onboarding/survey",
            headers={"Authorization": f"Bearer {token}"}
        )
        if response.status_code == 200:
            return response.json()
        return {}
    except Exception as e:
        st.error(f"Error loading survey: {e}")
        return {}


def submit_survey(token: str, responses: Dict[str, Any]) -> Dict[str, Any]:
    """Submit survey responses to API"""
    try:
        response = requests.post(
            f"{API_BASE_URL}/api/onboarding/submit",
            headers={"Authorization": f"Bearer {token}"},
            json={"responses": responses}
        )
        if response.status_code == 200:
            return response.json()
        else:
            st.error(f"Error: {response.status_code} - {response.text}")
            return {}
    except Exception as e:
        st.error(f"Error submitting survey: {e}")
        return {}


def show_completed_onboarding(status: Dict[str, Any]):
    """Show completion message for users who already completed onboarding"""
    st.success("✅ You've already completed onboarding!")
    st.write(f"You have **{status['persona_count']} persona(s)** set up.")
    st.write("Visit the Dashboard to see your personas and start using Multitudes!")
    
    if st.button("Retake Survey", help="Start fresh with new personas"):
        st.session_state.retake_survey = True
        st.rerun()


def render_phase_1(responses: Dict[str, Any], phase_config: Dict[str, Any]):
    """Phase 1: Discovering Your Multitudes"""
    st.write(phase_config["description"])
    st.write(f"⏱️ Estimated time: {phase_config['time_estimate']}")
    
    questions = phase_config["questions"]
    
    # Question 1: Archetype selection
    q1 = questions[0]
    st.subheader(q1["text"])
    st.caption(q1.get("help_text", ""))
    selected = st.multiselect(
        "Select all that apply:",
        options=q1["options"],
        key="archetypes_selection",
        default=responses.get("archetypes_selection", [])
    )
    responses["archetypes_selection"] = selected
    
    # Question 2: Custom names
    if selected:
        q2 = questions[1]
        st.subheader(q2["text"])
        st.caption(q2.get("help_text", ""))
        custom_names = st.text_input(
            "Comma-separated names:",
            value=responses.get("custom_persona_names", ""),
            placeholder=q2.get("placeholder", ""),
            key="custom_persona_names"
        )
        responses["custom_persona_names"] = custom_names
    
    # Question 3: Neglected personas
    q3 = questions[2]
    st.subheader(q3["text"])
    st.caption(q3.get("help_text", ""))
    neglected = st.multiselect(
        "Select areas:",
        options=q3["options"],
        key="neglected_personas",
        default=responses.get("neglected_personas", [])
    )
    responses["neglected_personas"] = neglected


def render_phase_2(responses: Dict[str, Any], phase_config: Dict[str, Any]):
    """Phase 2: Energy Mapping"""
    st.write(phase_config["description"])
    st.write(f"⏱️ Estimated time: {phase_config['time_estimate']}")
    
    questions = phase_config["questions"]
    
    # Question 1: Overall energy pattern
    q1 = questions[0]
    st.subheader(q1["text"])
    energy_pattern = st.radio(
        "Select your peak energy time:",
        options=q1["options"],
        index=0,
        key="overall_energy_pattern"
    )
    responses["overall_energy_pattern"] = energy_pattern
    
    # Question 2: Energy dip
    q2 = questions[1]
    st.subheader(q2["text"])
    has_dip = st.radio(
        "Do you experience energy dips?",
        options=q2["options"],
        index=0,
        key="energy_dip"
    )
    responses["energy_dip"] = has_dip
    
    # Question 3: Dip timing (conditional)
    if "Yes" in has_dip or "Sometimes" in has_dip:
        q3 = questions[2]
        st.subheader(q3["text"])
        st.caption(q3.get("help_text", ""))
        dip_time = st.radio(
            "When does it occur?",
            options=q3["options"],
            key="energy_dip_time"
        )
        responses["energy_dip_time"] = dip_time
    
    # Question 4: Recovery strategies
    q4 = questions[3]
    st.subheader(q4["text"])
    recovery = st.multiselect(
        "What helps you recover?",
        options=q4["options"],
        key="recovery_strategies",
        default=responses.get("recovery_strategies", [])
    )
    responses["recovery_strategies"] = recovery


def render_phase_3(responses: Dict[str, Any], phase_config: Dict[str, Any]):
    """Phase 3: Task Alignment"""
    st.write(phase_config["description"])
    st.write(f"⏱️ Estimated time: {phase_config['time_estimate']}")
    
    questions = phase_config["questions"]
    
    # Question 1: Task timing preferences
    q1 = questions[0]
    st.subheader(q1["text"])
    st.caption(q1.get("help_text", ""))
    task_timing = st.multiselect(
        "Select preferences:",
        options=q1["options"],
        key="task_by_time",
        default=responses.get("task_by_time", [])
    )
    responses["task_by_time"] = task_timing
    
    # Question 2: Time allocation
    q2 = questions[1]
    st.subheader(q2["text"])
    st.caption(q2.get("help_text", ""))
    time_alloc = st.text_area(
        "Enter time allocations:",
        value=responses.get("weekly_time_allocation", ""),
        placeholder=q2.get("placeholder", ""),
        key="weekly_time_allocation",
        height=100
    )
    responses["weekly_time_allocation"] = time_alloc
    
    # Question 3: Task switching
    q3 = questions[2]
    st.subheader(q3["text"])
    switching = st.radio(
        "Your preference:",
        options=q3["options"],
        key="task_switching"
    )
    responses["task_switching"] = switching


def render_phase_4(responses: Dict[str, Any], phase_config: Dict[str, Any]):
    """Phase 4: Balance Goals"""
    st.write(phase_config["description"])
    st.write(f"⏱️ Estimated time: {phase_config['time_estimate']}")
    
    questions = phase_config["questions"]
    
    # Question 1: Current imbalance
    q1 = questions[0]
    st.subheader(q1["text"])
    imbalance = st.radio(
        "Select one:",
        options=q1["options"],
        key="current_imbalance"
    )
    responses["current_imbalance"] = imbalance
    
    # Question 2: 30-day intention
    q2 = questions[1]
    st.subheader(q2["text"])
    st.caption(q2.get("help_text", ""))
    intention = st.text_area(
        "Your intention:",
        value=responses.get("thirty_day_intention", ""),
        placeholder=q2.get("placeholder", ""),
        key="thirty_day_intention",
        height=80
    )
    responses["thirty_day_intention"] = intention
    
    # Question 3: Biggest challenge
    q3 = questions[2]
    st.subheader(q3["text"])
    challenge = st.radio(
        "Select one:",
        options=q3["options"],
        key="biggest_challenge"
    )
    responses["biggest_challenge"] = challenge


def render_phase_5(responses: Dict[str, Any], phase_config: Dict[str, Any]):
    """Phase 5: Activation"""
    st.write(phase_config["description"])
    st.write(f"⏱️ Estimated time: {phase_config['time_estimate']}")
    
    questions = phase_config["questions"]
    
    # Question 1: Reminder style
    q1 = questions[0]
    st.subheader(q1["text"])
    reminder = st.radio(
        "Select preference:",
        options=q1["options"],
        key="reminder_style"
    )
    responses["reminder_style"] = reminder
    
    # Question 2: Tracking preference
    q2 = questions[1]
    st.subheader(q2["text"])
    tracking = st.radio(
        "Detail level:",
        options=q2["options"],
        key="tracking_preference"
    )
    responses["tracking_preference"] = tracking
    
    # Question 3: Privacy comfort
    q3 = questions[2]
    st.subheader(q3["text"])
    st.caption(q3.get("help_text", ""))
    privacy = st.multiselect(
        "Future options:",
        options=q3["options"],
        key="privacy_comfort",
        default=responses.get("privacy_comfort", [])
    )
    responses["privacy_comfort"] = privacy


def main():
    st.set_page_config(page_title="Onboarding - Multitudes", page_icon="🎭", layout="wide")
    
    st.title("🎭 Welcome to Multitudes")
    st.subheader("Discover the multitudes within you")
    
    # Check authentication
    token = check_authentication()
    
    # Check onboarding status
    status = check_onboarding_status(token)
    
    # If already completed and not retaking
    if status.get("completed") and not st.session_state.get("retake_survey", False):
        show_completed_onboarding(status)
        return
    
    # Initialize session state
    if "survey_responses" not in st.session_state:
        st.session_state.survey_responses = {}
    if "current_phase" not in st.session_state:
        st.session_state.current_phase = 0
    
    # Get survey configuration
    survey_config = get_survey_config(token)
    if not survey_config:
        st.error("Could not load survey configuration")
        return
    
    phases = survey_config.get("phases", [])
    if not phases:
        st.error("No survey phases available")
        return
    
    total_phases = len(phases)
    current_phase = st.session_state.current_phase
    
    # Progress bar
    progress = (current_phase) / total_phases
    st.progress(progress, text=f"Phase {current_phase + 1} of {total_phases}")
    
    # Render current phase
    st.markdown("---")
    phase_config = phases[current_phase]
    st.header(f"{phase_config['icon']} {phase_config['title']}")
    
    responses = st.session_state.survey_responses
    
    if current_phase == 0:
        render_phase_1(responses, phase_config)
    elif current_phase == 1:
        render_phase_2(responses, phase_config)
    elif current_phase == 2:
        render_phase_3(responses, phase_config)
    elif current_phase == 3:
        render_phase_4(responses, phase_config)
    elif current_phase == 4:
        render_phase_5(responses, phase_config)
    
    # Navigation buttons
    st.markdown("---")
    col1, col2, col3 = st.columns([1, 1, 1])
    
    with col1:
        if current_phase > 0:
            if st.button("⬅️ Back"):
                st.session_state.current_phase -= 1
                st.rerun()
    
    with col2:
        if st.button("Skip →", help="You can complete this later"):
            st.info("You can complete onboarding anytime from this page")
            st.stop()
    
    with col3:
        if current_phase < total_phases - 1:
            if st.button("Next ➡️", type="primary"):
                st.session_state.current_phase += 1
                st.rerun()
        else:
            if st.button("✨ Complete Setup", type="primary"):
                with st.spinner("Creating your personas..."):
                    result = submit_survey(token, responses)
                    
                    if result:
                        st.balloons()
                        st.success(f"🎉 {result['message']}")
                        st.write(f"**Created {result['personas_created']} persona(s):**")
                        
                        for persona in result.get("personas", []):
                            st.write(f"- {persona['emoji']} **{persona['name']}** ({persona['archetype']})")
                        
                        # Clear session state
                        st.session_state.retake_survey = False
                        st.session_state.current_phase = 0
                        st.session_state.survey_responses = {}
                        
                        st.info("Head to the Dashboard to see your personas!")
                        if st.button("Go to Dashboard"):
                            st.switch_page("streamlit_app.py")


if __name__ == "__main__":
    main()
