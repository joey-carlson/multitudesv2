"""
Streamlit Dashboard for Multitudes.

Multi-user testing interface for adaptive context learning.
Runs on port 2700.
"""

import streamlit as st
import requests
from datetime import datetime
import json

# API Configuration
API_URL = "http://localhost:2701"

# Page configuration
st.set_page_config(
    page_title="Multitudes - Context Learning Dashboard",
    page_icon="🧠",
    layout="wide",
)

# Initialize session state
if "token" not in st.session_state:
    st.session_state.token = None
if "user_id" not in st.session_state:
    st.session_state.user_id = None
if "display_name" not in st.session_state:
    st.session_state.display_name = None


def api_call(endpoint: str, method: str = "GET", data: dict = None, auth_required: bool = True):
    """Make API call with authentication"""
    headers = {}
    
    if auth_required and st.session_state.token:
        headers["Authorization"] = f"Bearer {st.session_state.token}"
    
    url = f"{API_URL}{endpoint}"
    
    try:
        if method == "GET":
            response = requests.get(url, headers=headers)
        elif method == "POST":
            response = requests.post(url, headers=headers, json=data)
        else:
            return None, f"Unsupported method: {method}"
        
        if response.status_code == 200 or response.status_code == 201:
            return response.json(), None
        else:
            return None, f"Error {response.status_code}: {response.text}"
    
    except Exception as e:
        return None, f"Connection error: {str(e)}"


def login_page():
    """Login page"""
    st.title("🧠 Multitudes")
    st.subheader("Adaptive Personal AI Assistant")
    
    st.markdown("---")
    
    st.markdown("""
    ### Welcome to Multitudes Testing
    
    This dashboard demonstrates **Phase 1: Adaptive Personalization** through dynamic prompts.
    
    Each tester gets a unique passphrase that isolates their context and learning.
    """)
    
    st.markdown("---")
    
    col1, col2 = st.columns([2, 1])
    
    with col1:
        st.markdown("### Test Passphrases")
        st.code("""
purple-monkey-dishwasher  →  Test User 1
correct-horse-battery     →  Test User 2
flying-toaster-banana     →  Test User 3
cosmic-panda-sunrise      →  Test User 4
quantum-dolphin-jazz      →  Test User 5
        """)
    
    with col2:
        st.markdown("### Login")
        passphrase = st.text_input(
            "Enter your passphrase",
            type="password",
            placeholder="purple-monkey-dishwasher"
        )
        
        if st.button("🔐 Login", use_container_width=True):
            if not passphrase:
                st.error("Please enter a passphrase")
                return
            
            # Call login endpoint
            data, error = api_call(
                "/auth/login",
                method="POST",
                data={"passphrase": passphrase},
                auth_required=False
            )
            
            if error:
                st.error(f"Login failed: {error}")
            elif data:
                st.session_state.token = data["access_token"]
                st.session_state.user_id = data["user_id"]
                st.session_state.display_name = data.get("display_name")
                st.success(f"✅ Logged in as {st.session_state.display_name}")
                st.rerun()


def dashboard_page():
    """Main dashboard"""
    
    # Header
    col1, col2, col3 = st.columns([2, 1, 1])
    with col1:
        st.title(f"Welcome, {st.session_state.display_name}!")
    with col3:
        if st.button("🚪 Logout"):
            st.session_state.token = None
            st.session_state.user_id = None
            st.session_state.display_name = None
            st.rerun()
    
    st.markdown("---")
    
    # Tabs
    tab1, tab2, tab3, tab4 = st.tabs([
        "📊 Context Overview",
        "📈 Statistics",
        "➕ Add Context",
        "💬 Submit Feedback"
    ])
    
    # Tab 1: Context Overview
    with tab1:
        st.subheader("Your Learned Context")
        
        if st.button("🔄 Refresh Context"):
            st.rerun()
        
        # Fetch user context
        context_data, error = api_call("/api/context")
        
        if error:
            st.error(f"Error loading context: {error}")
        elif context_data:
            col1, col2 = st.columns(2)
            
            with col1:
                st.markdown("### 🎯 Preferences")
                if context_data.get("preferences"):
                    for key, value in context_data["preferences"].items():
                        st.markdown(f"- **{key}**: {value}")
                else:
                    st.info("No preferences learned yet. Add some in the 'Add Context' tab!")
                
                st.markdown("### 📊 Statistics")
                if context_data.get("stats"):
                    for key, value in context_data["stats"].items():
                        st.metric(key.replace("_", " ").title(), f"{value:.2f}" if isinstance(value, float) else value)
                else:
                    st.info("No statistics yet")
            
            with col2:
                st.markdown("### 🔍 Behavioral Patterns")
                if context_data.get("patterns"):
                    for pattern in context_data["patterns"]:
                        st.markdown(f"- {pattern}")
                else:
                    st.info("No patterns detected yet")
                
                st.markdown("### 🎭 Persona Affinities")
                if context_data.get("persona_affinities"):
                    for persona, affinity in context_data["persona_affinities"].items():
                        st.progress(affinity, text=f"{persona}: {affinity:.0%}")
                else:
                    st.info("No persona affinities yet")
    
    # Tab 2: Statistics
    with tab2:
        st.subheader("Context Statistics")
        
        stats_data, error = api_call("/api/context/stats")
        
        if error:
            st.error(f"Error loading stats: {error}")
        elif stats_data:
            col1, col2, col3 = st.columns(3)
            
            with col1:
                st.metric("Total Contexts", stats_data.get("total_contexts", 0))
            with col2:
                st.metric("Avg Confidence", f"{stats_data.get('average_confidence', 0):.0%}")
            with col3:
                oldest = stats_data.get("oldest_context")
                if oldest:
                    days_ago = (datetime.utcnow() - datetime.fromisoformat(oldest.replace('Z', ''))).days
                    st.metric("Oldest Context", f"{days_ago} days ago")
                else:
                    st.metric("Oldest Context", "N/A")
            
            st.markdown("---")
            
            col1, col2 = st.columns(2)
            
            with col1:
                st.markdown("### By Type")
                by_type = stats_data.get("by_type", {})
                if by_type:
                    for ctx_type, count in by_type.items():
                        st.markdown(f"- **{ctx_type}**: {count}")
                else:
                    st.info("No data yet")
            
            with col2:
                st.markdown("### By Source")
                by_source = stats_data.get("by_source", {})
                if by_source:
                    for source, count in by_source.items():
                        st.markdown(f"- **{source}**: {count}")
                else:
                    st.info("No data yet")
    
    # Tab 3: Add Context
    with tab3:
        st.subheader("Manually Add Context")
        st.markdown("Add preferences, patterns, or statistics to test the learning system.")
        
        context_type = st.selectbox(
            "Context Type",
            ["preference", "pattern", "stat", "persona_affinity"]
        )
        
        key = st.text_input("Key", placeholder="e.g., work_style, peak_energy_hours")
        
        value_input = st.text_area(
            "Value (JSON format for complex values)",
            placeholder='e.g., "analytical" or {"hours": [9, 10, 11]}'
        )
        
        confidence = st.slider("Confidence", 0.0, 1.0, 0.8, 0.1)
        
        if st.button("➕ Add Context"):
            if not key or not value_input:
                st.error("Please fill in all fields")
            else:
                try:
                    # Try to parse as JSON, fall back to string
                    try:
                        value = json.loads(value_input)
                    except:
                        value = value_input
                    
                    data, error = api_call(
                        "/api/context",
                        method="POST",
                        data={
                            "context_type": context_type,
                            "key": key,
                            "value": value,
                            "confidence": confidence
                        }
                    )
                    
                    if error:
                        st.error(f"Error: {error}")
                    else:
                        st.success("✅ Context added successfully!")
                        st.balloons()
                except Exception as e:
                    st.error(f"Error: {str(e)}")
    
    # Tab 4: Submit Feedback
    with tab4:
        st.subheader("Submit Feedback")
        st.markdown("Simulate user feedback to test the learning loop.")
        
        interaction_type = st.selectbox(
            "Interaction Type",
            ["task_suggestion", "persona_detection", "energy_forecast", "schedule_optimization"]
        )
        
        feedback_type = st.selectbox(
            "Feedback Type",
            ["accepted", "rejected", "modified"]
        )
        
        st.markdown("### Interaction Data (JSON)")
        interaction_data = st.text_area(
            "What was suggested?",
            placeholder='{"suggested_task": "Write code", "time": "09:00"}',
            height=100
        )
        
        st.markdown("### Feedback Data (JSON)")
        feedback_data = st.text_area(
            "Additional feedback details",
            placeholder='{"reason": "Good timing", "actual_task": "Write code"}',
            height=100
        )
        
        if st.button("📤 Submit Feedback"):
            try:
                interaction_json = json.loads(interaction_data) if interaction_data else {}
                feedback_json = json.loads(feedback_data) if feedback_data else {}
                
                data, error = api_call(
                    "/api/feedback",
                    method="POST",
                    data={
                        "interaction_type": interaction_type,
                        "interaction_data": interaction_json,
                        "feedback_type": feedback_type,
                        "feedback_data": feedback_json
                    }
                )
                
                if error:
                    st.error(f"Error: {error}")
                else:
                    st.success("✅ Feedback submitted! The system is learning...")
                    st.info("Check the Context Overview to see how the system adapted!")
            except json.JSONDecodeError:
                st.error("Invalid JSON format")
            except Exception as e:
                st.error(f"Error: {str(e)}")


# Main app logic
def main():
    """Main application"""
    
    # Check if logged in
    if not st.session_state.token:
        login_page()
    else:
        # Verify token is still valid
        user_info, error = api_call("/auth/me")
        if error:
            st.error("Session expired. Please login again.")
            st.session_state.token = None
            st.rerun()
        else:
            dashboard_page()


if __name__ == "__main__":
    main()
